locals {
  categories = {
    food_groceries = {
      name  = "Food & Groceries"
      notes = "Groceries, dining out, coffee, kopitiam, delivery (GrabFood / foodpanda)."
    }
    transport = {
      name  = "Transport"
      notes = "Fuel, tolls, LRT/MRT/KTM, ride-hail (Grab / inDrive), parking. Excludes car-ownership costs (see Car)."
    }
    car = {
      name  = "Car"
      notes = <<-EOT
        Car savings + future ownership. Down-payment build-up (tag
        `car-fund` on transfers to Maybank Savings), and later:
        monthly loan instalment, road tax + insurance renewal,
        servicing, spares. Fuel/tolls stay under Transport.
      EOT
    }
    health_medical = {
      name  = "Health & Medical"
      notes = <<-EOT
        Own medical: GP, specialist, dental, pharmacy, hospital,
        mental-health consult, annual checkup. Tag `lhdn-relief`
        for anything filable under the medical / checkup / mental-
        health reliefs. Parents' medical goes under Family & Parents
        (separate LHDN bucket, RM 8,000).
      EOT
    }
    insurance_prs = {
      name  = "Insurance & PRS"
      notes = <<-EOT
        Life insurance premiums (non-EPF portion), medical /
        hospitalisation insurance, PRS (Private Retirement Scheme)
        contributions, deferred annuity. Strong LHDN relief
        candidates — always tag `lhdn-relief`. Caps: life-insurance
        RM 3,000 (if non-EPF); PRS + deferred annuity RM 3,000;
        education/medical insurance RM 3,000.
      EOT
    }
    lifestyle = {
      name  = "Lifestyle"
      notes = <<-EOT
        LHDN general lifestyle relief (RM 2,500 cap): reading
        material, personal PC / smartphone / tablet (not for
        business), monthly internet subscription in own name, gym
        membership, sports equipment. Tag `lhdn-relief`.
      EOT
    }
    sports_fitness = {
      name  = "Sports & Fitness"
      notes = <<-EOT
        Additional sports relief (RM 1,000, stacks on lifestyle):
        gym fees, coach/trainer, sports club membership, competition
        entry fees, gear specifically for a sport (racket, boots,
        bike parts). Tag `lhdn-relief`.
      EOT
    }
    education_certs = {
      name  = "Education & Certifications"
      notes = <<-EOT
        Career upskilling — cloud/SRE certification exam fees (AWS /
        GCP / CKA / CKAD / Terraform), online courses, professional
        qualifications, technical books bought for study, Masters
        tuition if pursued. Falls under LHDN self-education relief
        (RM 7,000); tag `lhdn-relief` and `career`.
      EOT
    }
    zakat_donations = {
      name  = "Zakat & Donations"
      notes = <<-EOT
        Zakat (pendapatan / fitrah / harta) and donations to
        LHDN-approved bodies. Zakat is a direct rebate against tax
        payable (not a relief on income); donations are capped at
        10% of aggregate income. Always tag `lhdn-relief`.
      EOT
    }
    family_parents = {
      name  = "Family & Parents"
      notes = <<-EOT
        Parents' medical (LHDN: RM 8,000), parental care allowance
        (LHDN: RM 3,000 if not claiming medical), family gatherings,
        gifts to parents/siblings, filial support. Tag with `parents`
        and `lhdn-relief` where applicable.
      EOT
    }
    relationship = {
      name  = "Relationship"
      notes = <<-EOT
        Partner-related spend: dates, joint meals, gifts, joint
        holidays (also tag `travel` for the travel portion), shared
        subscriptions. Tag `partner` on every transaction for
        rollup regardless of category.
      EOT
    }
    travel = {
      name  = "Travel"
      notes = "Flights, accommodation, holiday spending, travel insurance for the trip. Domestic + overseas."
    }
    entertainment = {
      name  = "Entertainment"
      notes = "Cinema, concerts, gigs, video games, hobbies, board games, events. Not LHDN-relief-eligible (cinema/games specifically excluded from lifestyle relief)."
    }
    shopping = {
      name  = "Shopping"
      notes = "Clothing, footwear, accessories, household non-essentials, homeware. Distinct from Lifestyle (which is the LHDN-relief bucket)."
    }
    subscriptions = {
      name  = "Subscriptions"
      notes = "Streaming (Netflix, Spotify, YouTube Premium), SaaS (1Password, GitHub, cloud personal). Internet in own name goes under Lifestyle for LHDN relief; general SaaS here."
    }
    fees_charges = {
      name  = "Fees & Charges"
      notes = "Bank fees, ATM fees, FX conversion spread, credit-card interest (if ever), late fees, government fees (MyKad, passport renewal)."
    }
    miscellaneous = {
      name  = "Miscellaneous"
      notes = <<-EOT
        True catch-all. If a transaction sits here for more than a
        month, the taxonomy is missing a bucket — promote it to its
        own category. Career / cert-exam spend should NOT sit here;
        it belongs in Education & Certifications for LHDN tracking.
      EOT
    }
  }
}

resource "fireflyiii_category" "this" {
  for_each = local.categories

  name  = each.value.name
  notes = each.value.notes
}
