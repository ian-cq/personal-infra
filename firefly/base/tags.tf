# Baseline transaction tags. Tags cross-cut categories: a "Food"
# transaction can also be `recurring` (subscription delivery) or
# `reimbursable` (client meal), and category alone can't express both.
#
# Kept small on purpose — a large tag vocabulary decays into
# free-text within a year. Prefer editing this list over adding tags
# ad-hoc in the Firefly UI so the taxonomy stays in git.
locals {
  tags = {
    recurring = {
      tag         = "recurring"
      description = "Transaction repeats on a fixed cadence (subscriptions, rent, bills)."
    }
    one_off = {
      tag         = "one-off"
      description = "Non-recurring, will not repeat."
    }
    reimbursable = {
      tag         = "reimbursable"
      description = "Expense to be reimbursed by employer / client / friend."
    }
    reimbursed = {
      tag         = "reimbursed"
      description = "Was reimbursable, reimbursement received. Pairs with a matching revenue txn."
    }
    business = {
      tag         = "business"
      description = "Business-related; may be tax-deductible."
    }
    tax_deductible = {
      tag         = "tax-deductible"
      description = "Claim on annual tax return."
    }
    gift = {
      tag         = "gift"
      description = "Given to or received from another person."
    }
  }
}

resource "fireflyiii_tag" "this" {
  for_each = local.tags

  tag         = each.value.tag
  description = each.value.description
}
