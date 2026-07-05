output "rytbank" {
  description = "RytBank asset account."
  value = {
    id   = fireflyiii_account.rytbank.id
    name = fireflyiii_account.rytbank.name
    type = fireflyiii_account.rytbank.type
  }
}

output "maybank" {
  description = "Maybank Savings asset account."
  value = {
    id   = fireflyiii_account.maybank.id
    name = fireflyiii_account.maybank.name
    type = fireflyiii_account.maybank.type
  }
}

output "tng_ewallet" {
  description = "Touch 'n Go eWallet asset account."
  value = {
    id   = fireflyiii_account.tng_ewallet.id
    name = fireflyiii_account.tng_ewallet.name
    type = fireflyiii_account.tng_ewallet.type
  }
}

output "uob_credit" {
  description = "UOB credit card asset account."
  value = {
    id   = fireflyiii_account.uob_credit.id
    name = fireflyiii_account.uob_credit.name
    type = fireflyiii_account.uob_credit.type
  }
}

output "maybank_credit" {
  description = "Maybank credit card asset account."
  value = {
    id   = fireflyiii_account.maybank_credit.id
    name = fireflyiii_account.maybank_credit.name
    type = fireflyiii_account.maybank_credit.type
  }
}

output "salary" {
  description = "Employer payroll revenue account."
  value = {
    id   = fireflyiii_account.salary.id
    name = fireflyiii_account.salary.name
    type = fireflyiii_account.salary.type
  }
}

output "reimbursements" {
  description = "Expense reimbursements revenue account."
  value = {
    id   = fireflyiii_account.reimbursements.id
    name = fireflyiii_account.reimbursements.name
    type = fireflyiii_account.reimbursements.type
  }
}
