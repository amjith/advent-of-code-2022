import strutils
import std/algorithm
import std/sugar
import std/sequtils

proc countCalories(filename: File): int =
  var calories = 0
  var totalCalories: seq[int]
  for line in filename.lines:
    if line == "":
      totalCalories.add(calories)
      calories = 0
    else:
      calories += parseInt(line)
  totalCalories.sort(Descending)
  totalCalories[0..2].foldl(a + b)

echo countCalories(open("day1.input"))
