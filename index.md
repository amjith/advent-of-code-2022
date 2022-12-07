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

# Day 5

Classes are methods are a little weird. I'm still not sure what's the difference between a `proc` and a `method`.

```
type
  Stack = object
    boxes: seq[char]

proc add(self: var Stack, box: char, append: bool) = 
  if box.isAlphaAscii:
    if append:
      self.boxes.add(box)
    else:
      self.boxes.insert(box, 0)

proc remove(self: var Stack): char = return pop(self.boxes)
```

The `self` arg needs to be a `var` so we can modify it. 

# Day 7

```
type
  ElfDir = ref object
    parent: ElfDir
    name: string
    files: Table[string, ElfFile]
    dirs: Table[string, ElfDir]
```

The object is of type `ref`. This makes it a reference. The `proc` that accesses it doesn't have to declare the self as a `var` because we're manipulating the reference directly (?). Also this has to be a ref so we can build a tree where one of the params in the class is self-referential.
