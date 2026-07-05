# firefly/base

Terraform-managed baseline for the Firefly III instance at
`https://firefly.api.quanianitis.com` (Kubernetes svc `firefly/firefly`,
`inbox-apikey` SecurityPolicy at the gateway).

Manages: 4 asset accounts (RytBank, Maybank Savings, TNG eWallet,
UOB Credit), 2 revenue accounts (Salary, Reimbursements), 17
expense categories, 12 cross-cutting tags. Provider
`terraform.quanianitis.com/ian-cq/firefly-iii` (≥ 0.5.3). State in
`gs://quanianitis-terraform-state-backend` under `firefly/base/`.

`.tf` files in this directory carry **no `#` comments** — all
context lives in the resources' own `notes` / `description` fields
so it renders in the Firefly UI (the actual consumer). This README
is the only free-form doc surface.

## Money flow

```
Salary (revenue) ──► Maybank Savings (savingAsset, payroll landing)
                       │
                       ├──► RytBank (defaultAsset, daily driver — sweep on payday)
                       │       │
                       │       ├──► TNG eWallet (cashWalletAsset, F&B + tolls)
                       │       └──► UOB Credit (ccAsset, monthlyFull) ──► paid off from RytBank
                       │
                       └── residual stays in Maybank as emergency fund + car-fund build-up.

Reimbursements (revenue) ──► whichever asset originally paid the expense.
```

## LHDN Form BE relief cheat-sheet

Filter Firefly reports by tag `lhdn-relief` at year-end, group by
category, reconcile against these caps (2025 rates, review yearly):

| Category                    | LHDN relief bucket                                                | Cap (MYR)              |
| --------------------------- | ----------------------------------------------------------------- | ---------------------- |
| Lifestyle                   | Books, personal PC/phone/tablet, home internet, gym, sports gear  | 2,500                  |
| Sports & Fitness            | Sports activities, coach, competition entry (stacks on lifestyle) | 1,000                  |
| Health & Medical            | Serious illness / medical                                         | 10,000                 |
| Health & Medical            | Full medical checkup                                              | 1,000                  |
| Health & Medical            | Mental-health consult                                             | 1,000                  |
| Insurance & PRS             | Life insurance (non-EPF)                                          | 3,000                  |
| Insurance & PRS             | PRS + deferred annuity                                            | 3,000                  |
| Insurance & PRS             | Education / medical insurance                                     | 3,000                  |
| Education & Certifications  | Self-education tuition (cloud certs, Masters, prof quals)         | 7,000                  |
| Zakat & Donations           | Zakat & fitrah                                                    | 100% rebate on payable |
| Zakat & Donations           | Approved-body donations                                           | 10% of aggregate       |
| Family & Parents (+parents) | Parents' medical / dental                                         | 8,000                  |
| Family & Parents (+parents) | Parental care (if not claiming medical)                           | 3,000                  |

## Bootstrap (one-shot)

Two 1Password items in vault `quanianitis.com`:

```sh
op item create --category=password --vault='quanianitis.com' \
  --title='firefly_pat_token' \
  'password=<paste PAT from Firefly UI: Options → Profile → OAuth → Personal Access Tokens>'

op item create --category=password --vault='quanianitis.com' \
  --title='gateway_homelab_auth' \
  'password=<same value fed to in-cluster gateway-homelab-auth Secret via ESO>'
```

## Running

```sh
terraform init
terraform plan
terraform apply
```

Auth is baked into the provider config: gateway apikey → `X-API-Key`,
Firefly PAT → `Authorization: Bearer`. Both sourced from 1Password
via `vault.tf`.

## Layout

`version.tf` providers · `main.tf` backend+provider · `variables.tf`
knobs · `vault.tf` 1P data · `accounts.tf` · `categories.tf` · `tags.tf`.

## Editing

- **Category / tag**: edit `local.categories` / `local.tags`. Map
  keys are stable; renaming the `name` / `tag` string is safe
  (matched by ID). Everything explanatory goes in the `notes` /
  `description` value, never in a `#` comment.
- **Account**: copy a `resource "fireflyiii_account"` block. Keep
  `account_role` valid for `type`. Rationale goes in `notes`.
- **Currency**: `var.default_currency`. Firefly replaces (destroys)
  accounts on a currency change; migrate history first.

## Not managed (deliberate scope)

Transactions (UI/app). Budgets + limits (`firefly/budgets/` later).
Rules + recurring (`firefly/rules/` later, once categories are stable).
