abstract sig Entry {
  parent: lone Dir
}
sig File extends Entry {}
sig Dir extends Entry {}
one sig Root extends Dir {}

fact RootNoParent { no Root.parent }

fact OneParent { all e: Entry - Root | one e.parent }

fact NoSelfParent { no d: Dir | d in d.parent }

fact NoMutualParent {
  no disj d1, d2: Dir | d1 in d2.parent and d2 in d1.parent
}

assert FileHasParent { all f: File | some f.parent }

assert NoCycle3 {
  no disj a, b, c: Dir |
    a.parent = b and b.parent = c and c.parent = a
}

assert DirParentIsRoot { all d: Dir - Root | d.parent = Root }

check FileHasParent    for 4
check FileHasParent    for 5
check FileHasParent    for 6
check NoCycle3         for 4
check NoCycle3         for 5
check NoCycle3         for 6
check DirParentIsRoot  for 4
check DirParentIsRoot  for 5
check DirParentIsRoot  for 6
