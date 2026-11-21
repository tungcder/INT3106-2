abstract sig Entry {
  parent: lone Dir
}
sig File extends Entry {}
sig Dir extends Entry {}
one sig Root extends Dir {}

fact RootNoParent { no Root.parent }

fact OneParent { all e: Entry - Root | one e.parent }

fact Acyclic { no e: Entry | e in e.^parent }

fact ReachRoot { all e: Entry | Root in e.*parent }

fact MaxThreeChildren { all d: Dir | #parent.d <= 3 }

pred FileAtDepthThree {
  some f: File | f.(parent.parent.parent) = Root
}

pred DirWithTwoFiles {
  some d: Dir | #(File & parent.d) = 2
}

pred DirWithThreeFilesInSubtree {
  some d: Dir | #(File & ^parent.d) >= 3
}

run FileAtDepthThree            for 6
run FileAtDepthThree            for 8 but 5 Int
run DirWithTwoFiles             for 6
run DirWithTwoFiles             for 8 but 5 Int
run DirWithThreeFilesInSubtree  for 6
run DirWithThreeFilesInSubtree  for 8 but 5 Int

assert RootIsAncestor { all e: Entry - Root | Root in e.^parent }

assert AncestorAntisymmetric {
  all a, b: Entry | a in b.^parent implies b not in a.^parent
}

assert SubtreeFilesBounded {
  all d: Dir | #parent.d <= 3 implies #(File & ^parent.d) <= 3
}

check RootIsAncestor          for 6
check RootIsAncestor          for 8 but 5 Int
check AncestorAntisymmetric   for 6
check AncestorAntisymmetric   for 8 but 5 Int
check SubtreeFilesBounded     for 6
check SubtreeFilesBounded     for 8 but 5 Int
