sig Author {}

sig Member {}

sig Book {
    author: some Author,
    borrow: lone Member
}

sig Librarian in Member {}

one sig Library {
    catalog: set Book,
    members: set Member
}

run {} for 5