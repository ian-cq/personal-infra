# Expense categories used to slice spending in reports.
#
# Kept intentionally small — Firefly's category dropdown gets noisy
# fast, and cross-category analysis needs consistent buckets. Add
# subcategories as tags (see tags.tf) rather than more categories.
#
# Renames are safe (Firefly matches by ID, terraform tracks by key
# below → keep the `for_each` keys stable even if the `name` changes).
locals {
  categories = {
    food_groceries = {
      name  = "Food & Groceries"
      notes = "Groceries, dining out, coffee, delivery."
    }
    transport = {
      name  = "Transport"
      notes = "Fuel, tolls, public transport, ride-hail, parking."
    }
    housing = {
      name  = "Housing"
      notes = "Rent / mortgage, maintenance, furnishing."
    }
    utilities = {
      name  = "Utilities"
      notes = "Electricity, water, internet, mobile."
    }
    health = {
      name  = "Health"
      notes = "Medical, dental, insurance, pharmacy, fitness."
    }
    entertainment = {
      name  = "Entertainment"
      notes = "Movies, games, events, hobbies."
    }
    shopping = {
      name  = "Shopping"
      notes = "Clothing, electronics, household non-essentials."
    }
    subscriptions = {
      name  = "Subscriptions"
      notes = "Recurring digital services (streaming, SaaS, memberships)."
    }
    travel = {
      name  = "Travel"
      notes = "Flights, accommodation, holiday spending."
    }
    fees_charges = {
      name  = "Fees & Charges"
      notes = "Bank fees, FX conversion, interest, penalties."
    }
  }
}

resource "fireflyiii_category" "this" {
  for_each = local.categories

  name  = each.value.name
  notes = each.value.notes
}
