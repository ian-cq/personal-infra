output "accounts" {
  description = "Map of Firefly account resources keyed by terraform resource name. Exposes the fields downstream stacks and rules commonly need (id for referencing, name/type/role for filtering)."
  value = {
    rytbank = {
      id           = fireflyiii_account.rytbank.id
      name         = fireflyiii_account.rytbank.name
      type         = fireflyiii_account.rytbank.type
      account_role = fireflyiii_account.rytbank.account_role
    }
    maybank_savings = {
      id           = fireflyiii_account.maybank_savings.id
      name         = fireflyiii_account.maybank_savings.name
      type         = fireflyiii_account.maybank_savings.type
      account_role = fireflyiii_account.maybank_savings.account_role
    }
    tng_ewallet = {
      id           = fireflyiii_account.tng_ewallet.id
      name         = fireflyiii_account.tng_ewallet.name
      type         = fireflyiii_account.tng_ewallet.type
      account_role = fireflyiii_account.tng_ewallet.account_role
    }
    uob_credit = {
      id           = fireflyiii_account.uob_credit.id
      name         = fireflyiii_account.uob_credit.name
      type         = fireflyiii_account.uob_credit.type
      account_role = fireflyiii_account.uob_credit.account_role
    }
    maybank_credit = {
      id           = fireflyiii_account.maybank_credit.id
      name         = fireflyiii_account.maybank_credit.name
      type         = fireflyiii_account.maybank_credit.type
      account_role = fireflyiii_account.maybank_credit.account_role
    }
    salary = {
      id           = fireflyiii_account.salary.id
      name         = fireflyiii_account.salary.name
      type         = fireflyiii_account.salary.type
      account_role = fireflyiii_account.salary.account_role
    }
    reimbursements = {
      id           = fireflyiii_account.reimbursements.id
      name         = fireflyiii_account.reimbursements.name
      type         = fireflyiii_account.reimbursements.type
      account_role = fireflyiii_account.reimbursements.account_role
    }
  }
}
