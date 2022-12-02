import strutils
import std/algorithm
import std/sequtils

proc countCalories(file: File): int =
  var calories = 0
  var totalCalories: seq[int]
  for line in file.lines:
    if line == "":
      totalCalories.add(calories)
      calories = 0
    else:
      calories += parseInt(line)
  totalCalories.sort(Descending)
  totalCalories[0..2].foldl(a + b)

echo countCalories(open("day1.input"))
