resource "fireflyiii_account" "rytbank" {
  name         = "RytBank"
  type         = "asset"
  account_role = "defaultAsset"
  currency_id  = data.fireflyiii_currency.default.id
  notes        = <<-EOT
    Ryt Bank (Sea Group) — digital-first daily driver. Funded by a
    payday sweep from Maybank Savings. Day-to-day spending, TNG
    reloads, and UOB credit-card payoff all originate here.
  EOT
}

resource "fireflyiii_account" "maybank" {
  name         = "Maybank"
  type         = "asset"
  account_role = "savingAsset"
  currency_id  = data.fireflyiii_currency.default.id
  notes        = <<-EOT
    Maybank savings account — payroll landing zone (employer credits
    salary here). On payday, sweep the month's spending budget to
    RytBank; residual stays put as emergency fund + car down-payment
    build-up. Tag inbound salary transfers earmarked for the car
    goal with `car-fund`. Not touched for daily spend.
  EOT
}

resource "fireflyiii_account" "tng_ewallet" {
  name         = "TNG eWallet"
  type         = "asset"
  account_role = "cashWalletAsset"
  currency_id  = data.fireflyiii_currency.default.id
  notes        = <<-EOT
    Touch 'n Go eWallet — tolls (SmartTAG / RFID reload), parking,
    small-ticket F&B, DuitNow QR payments. Reloaded from RytBank.
  EOT
}

resource "fireflyiii_account" "uob_credit" {
  name                 = "UOB Credit"
  type                 = "asset"
  account_role         = "ccAsset"
  credit_card_type     = "monthlyFull"
  monthly_payment_date = "2026-01-15"
  currency_id          = data.fireflyiii_currency.default.id
  notes                = <<-EOT
    UOB credit card — monthlyFull, statement paid in full every
    cycle from RytBank. Statement cycle placeholder 15th; adjust
    monthly_payment_date once the real cycle date is confirmed
    (in-place update, not replacement).
  EOT
}

resource "fireflyiii_account" "maybank_credit" {
  name                 = "Maybank Credit"
  type                 = "asset"
  account_role         = "ccAsset"
  credit_card_type     = "monthlyFull"
  monthly_payment_date = "2026-01-15"
  currency_id          = data.fireflyiii_currency.default.id
  notes                = <<-EOT
    Maybank credit card — monthlyFull, statement paid in full every
    cycle from RytBank. Statement cycle placeholder 15th; adjust
    monthly_payment_date once the real cycle date is confirmed.
  EOT
}

# Revenue accounts inherit per-transaction currency at runtime; Firefly
# ignores currency on write and returns the user's default on read.
# Deliberately omit currency_id/currency_code so the provider can pin
# both to null and avoid the drift.
resource "fireflyiii_account" "salary" {
  name  = "Salary"
  type  = "revenue"
  notes = <<-EOT
    Employer payroll. Net-of-EPF/SOCSO/EIS/PCB, i.e. take-home MYR
    landing in Maybank Savings on payday (employer requires a
    Maybank account for payroll). From there a monthly sweep funds
    RytBank; residual stays in Maybank as emergency fund + car-fund
    build-up. Statutory deductions are already withheld upstream and
    are not modelled as separate transactions (LHDN Form BE at year
    end reconciles gross vs. relief).
  EOT
}

resource "fireflyiii_account" "reimbursements" {
  name  = "Reimbursements"
  type  = "revenue"
  notes = <<-EOT
    Expense reimbursements from employer, clients, or friends. Pair
    with the `reimbursable` → `reimbursed` tag transition on the
    originating expense so the round-trip is auditable.
  EOT
}
