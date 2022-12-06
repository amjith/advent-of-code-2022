# Day 1

Use `nim c -r hello.nim` to compile and run at the same time.

Use `inim` (installed by `nimble install inim`) for a repl.

`sort()` is part of the `std/algorithm` module. 
`parseInt()` is part of `strutils` module.

`seq` is the equivalent of a list in python. An unbounded array.

`let` is like `final` in some languages. You can assign to it once but can't change it. This is different from `const` because const requires things to be a value at compile time but `let` can assign dynamic things at runtime once but never change again.

# Day 2

`import tables` to use hash tables.

Hash table example:

```
import tables
moveScore = {"A": 1, "B": 2, "C": 3}.toTable
moveScore["C"]  # 3
```

# Day 3


# Day 4


Generate a range of numbers
```
import sequtils
echo toSeq(0 .. 5)   # Create a sequence @[0, 1, 2, 3, 4, 5]
echo toHashSet(toSeq(2 .. 4))  # Create a set {2, 3, 4}
```

Also: 

{0 .. 5} creates a set {0, 1, 2, 3, 4, 5}
{2 .. 4} creates a set {2, 3, 4}
