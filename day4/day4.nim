import strutils
import sequtils
import sets

proc part1(): int =
  var overlaps = 0
  for line in lines("input.txt"):
    let chores = line.split(",")
    let sections = chores.map(proc (x: string): seq[int] = x.split("-").map(parseInt))
    let firstSection = toHashSet(toSeq(sections[0][0]..sections[0][1]))
    let secondSection = toHashSet(toSeq(sections[1][0]..sections[1][1]))
    if firstSection <= secondSection or secondSection <= firstSection:
      inc overlaps
  return overlaps

echo part1()

proc part2(): int =
  var overlaps = 0
  for line in lines("input.txt"):
    let chores = line.split(",")
    let sections = chores.map(proc (x: string): seq[int] = x.split("-").map(parseInt))
    let firstSection = toHashSet(toSeq(sections[0][0]..sections[0][1]))
    let secondSection = toHashSet(toSeq(sections[1][0]..sections[1][1]))
    if len(firstSection * secondSection) > 0:
      inc overlaps
  return overlaps

echo part2()
