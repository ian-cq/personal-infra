# Baseline accounts for personal-finance tracking in Firefly III.
#
# Naming convention: human-readable names, no prefix — Firefly's UI
# is the primary consumer. Renames on `name` are safe (no
# replacement). `type` and `account_role` changes force replacement,
# so those are the load-bearing fields.
#
# Currency is set via var.default_currency so re-denominating the
# whole set is a one-line change. Note: Firefly *replaces* an account
# when its currency changes (opening-balance semantics diverge), so a
# denomination change will destroy history-bearing accounts. Plan and
# review the diff first.

# --- Asset accounts ----------------------------------------------------

resource "fireflyiii_account" "checking" {
  name          = "Checking"
  type          = "asset"
  account_role  = "defaultAsset"
  currency_code = var.default_currency
  notes         = "Primary day-to-day bank account. Salary lands here."
}

resource "fireflyiii_account" "savings" {
  name          = "Savings"
  type          = "asset"
  account_role  = "savingAsset"
  currency_code = var.default_currency
  notes         = "Emergency fund + short-term savings."
}

resource "fireflyiii_account" "cash_wallet" {
  name          = "Cash Wallet"
  type          = "asset"
  account_role  = "cashWalletAsset"
  currency_code = var.default_currency
  notes         = "Physical cash on hand."
}

resource "fireflyiii_account" "credit_card" {
  name                 = "Credit Card"
  type                 = "asset"
  account_role         = "ccAsset"
  credit_card_type     = "monthlyFull"
  monthly_payment_date = "2026-01-01"
  currency_code        = var.default_currency
  notes                = "Monthly-full credit card. Statement paid off from Checking every cycle."
}

# --- Revenue accounts --------------------------------------------------
#
# In Firefly, revenue accounts are the *sources* of income (employer,
# clients, etc). Transactions land in an asset account and are
# categorised by the revenue account they came from.

resource "fireflyiii_account" "salary" {
  name          = "Salary"
  type          = "revenue"
  currency_code = var.default_currency
  notes         = "Employer payroll."
}

resource "fireflyiii_account" "reimbursements" {
  name          = "Reimbursements"
  type          = "revenue"
  currency_code = var.default_currency
  notes         = "Expense reimbursements from employer / clients / friends."
}
