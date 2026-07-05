# firefly/base

Terraform-managed baseline for the Firefly III instance at
`https://finance.62a.quanianitis.com` (Kubernetes service
`firefly/firefly`).

Manages:

- Asset accounts (Checking, Savings, Cash Wallet, Credit Card)
- Revenue accounts (Salary, Reimbursements)
- Expense categories (10, e.g. Food & Groceries, Transport, ...)
- Cross-cutting tags (recurring, reimbursable, tax-deductible, ...)

Uses the self-hosted provider
`terraform.quanianitis.com/ian-cq/firefly-iii`, source at
[`ian-cq/terraform-provider-firefly-iii`](https://github.com/ian-cq/terraform-provider-firefly-iii).
State is in the shared `quanianitis-terraform-state-backend` GCS
bucket under prefix `firefly/base`.

## Bootstrap (one-shot)

Firefly PAT must exist as a dedicated 1Password item in the
`quanianitis.com` vault with the token in its `password` field. Once:

```sh
op item create --category=password --vault='quanianitis.com' \
  --title='firefly_pat_token' \
  'password=<paste PAT from https://finance.62a.quanianitis.com/profile/oauth>'
```

Generate the PAT in the Firefly UI at
**Options → Profile → OAuth → Personal Access Tokens**. Give it a
name like `terraform-personal-infra` so revoking is scoped.

## Running

The Firefly API is on the same hostname as the UI
(`finance.62a.quanianitis.com`), which sits behind the Envoy Gateway
OIDC policy (Google login required for the whole
`*.62a.quanianitis.com` wildcard listener). Even PAT requests get
redirected to accounts.google.com, so the API is not reachable
directly from outside the cluster today.

Until either a dedicated api-key-gated hostname is set up (see
`~/claude-agent/logs/2026-07-05-terraform-provider-firefly-iii-smoke-test.md`
for the plan, "Option 2"), the tunnelling flow is:

```sh
# In one shell — leave running:
kubectl -n firefly port-forward svc/firefly 18080:8080

# In another shell, from this directory:
export FIREFLYIII_BASE_URL=http://localhost:18080
terraform init
terraform plan
terraform apply
```

Or one-liner (uses `trap` to always tear down the port-forward):

```sh
sh -c 'kubectl -n firefly port-forward svc/firefly 18080:8080 >/dev/null 2>&1 &
       PF=$!; trap "kill $PF" EXIT INT TERM
       sleep 2
       FIREFLYIII_BASE_URL=http://localhost:18080 terraform "$@"' -- apply
```

## Layout

| File            | Contents                                                  |
| --------------- | --------------------------------------------------------- |
| `version.tf`    | `required_providers` (onepassword, fireflyiii)            |
| `main.tf`       | GCS backend + provider config (base_url, PAT-from-1P)     |
| `variables.tf`  | `firefly_base_url`, `default_currency`                    |
| `vault.tf`      | 1Password data sources                                    |
| `accounts.tf`   | Asset + revenue accounts (explicit per-account resources) |
| `categories.tf` | Expense categories via `for_each` over `local.categories` |
| `tags.tf`       | Cross-cutting tags via `for_each` over `local.tags`       |

## Editing

- **Add / remove a category or tag**: edit `local.categories` /
  `local.tags`. The `for_each` key is stable; the `name` / `tag`
  string can change without replacement (Firefly matches by ID).
- **Add an asset account**: copy an existing `resource
  "fireflyiii_account" ...` block in `accounts.tf`. Keep
  `account_role` valid for the type (see
  [provider docs](https://github.com/ian-cq/terraform-provider-firefly-iii)).
- **Change default currency**: edit `variables.tf`. WARNING: Firefly
  replaces (destroys + recreates) accounts on a currency change,
  which loses history. Migrate manually before flipping this.

## Not managed here (intentional)

- **Transactions** — daily entries belong in the Firefly UI /
  mobile app, not in git.
- **Budgets and budget-limits** — planned separately in
  `firefly/budgets/` once the shape of monthly budgeting is stable.
- **Rules** — planned separately in `firefly/rules/` once the
  category taxonomy is proven.
- **Recurring transactions** — same as rules.
