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
      description = "Business-related; may be tax-deductible against side-gig income."
    }
    tax_deductible = {
      tag         = "tax-deductible"
      description = "Deductible against business/side-gig income (P&L), NOT personal LHDN relief — see `lhdn-relief` for that."
    }
    gift = {
      tag         = "gift"
      description = "Given to or received from another person."
    }
    lhdn_relief = {
      tag         = "lhdn-relief"
      description = "Claimable as LHDN individual tax relief on Form BE (medical, lifestyle, sports, education, insurance/PRS, zakat, parents' medical, etc.). Filter by this tag at year-end, sum by category, reconcile against the caps in each category's notes."
    }
    parents = {
      tag         = "parents"
      description = "Expense on / for parents. Combined with `lhdn-relief` marks the parents' medical (RM 8,000) or parental-care (RM 3,000) LHDN bucket."
    }
    partner = {
      tag         = "partner"
      description = "Relationship-related; joint spend, dates, gifts to partner, splittable expenses. Rolls up regardless of category."
    }
    car_fund = {
      tag         = "car-fund"
      description = "Earmarked toward the car down-payment goal. Apply to transfers landing in Maybank Savings so the sinking-fund balance can be filtered out of the general emergency-fund total."
    }
    career = {
      tag         = "career"
      description = "Career/professional-development related (cert exam, course, conference, technical books, work-adjacent tooling in own name). Usually pairs with Education & Certifications and `lhdn-relief` for the self-education bucket."
    }
  }
}

resource "fireflyiii_tag" "this" {
  for_each = local.tags

  tag         = each.value.tag
  description = each.value.description
}
