sig Dept {}
sig User {
    depts: set Dept,
    reads: set Doc
}
sig Doc {
    dept: one Dept,
    owner: one User
}

fact R1 {
    all u: User, d: Doc |
        d in u.reads implies d.owner = u
}

pred crossRead[u: User, d: Doc] {
    d in u.reads
    d.dept not in u.depts
}

assert OwnerOnlyCross {
    all u: User, d: u.reads |
        d.dept not in u.depts
        implies d.owner = u
}

check OwnerOnlyCross for 5
