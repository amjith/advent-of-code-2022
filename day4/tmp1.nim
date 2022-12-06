import std/[strutils, strscans]

var r1: Slice[int] = 1..5
var r2: Slice[int] = 1..3

proc contains[T](r1, r2: Slice[T]): bool =
  r1.a >= r2.a and r1.b <= r2.b

proc fullyOverlap[T](r1, r2: Slice[T]): bool =
  r1 in r2 or r2 in r1

echo fullyOverlap(r1, r2)
