import std/[strutils, sequtils]

proc compute(parts: seq[string]): (int, int) =
  case parts[0]:
    of "noop":
      return (1, 0)
    of "addx":
      return (2, parseInt(parts[1]))

proc populateCycleValues(data: string): array[240, int] = 
  var
    cycleValue: array[240, int]
  var
    totalCycle: int = 1
    totalX: int = 1
  for line in data.splitLines:
    let (cycle, x) = compute(line.split)
    for i in totalCycle ..< (totalCycle + cycle):
      cycleValue[i - 1] = totalX
    totalCycle += cycle
    totalX += x
  return cycleValue

proc display(data: array[240, int]): array[6, string] = 
  for i in 0 ..< 240:
    if ((data[i] - 1) <= i mod 40) and (i mod 40 <= (data[i] + 1)):
      result[i div 40].add("#") 
    else:
      result[i div 40].add(".") 
  return result

proc part2(data: string) = 
  let cycleValue = populateCycleValues(data)
  for line in display(cycleValue):
    echo line

proc part1(data: string): int = 
  var cycles = toSeq(countup(20, 220, 40))
  var cycleValue = populateCycleValues(data)
  for i in cycles:
    result += cycleValue[i - 1] * i 


#let data = readFile("small-input.txt")
let data = readFile("input.txt")
echo part1(data)
part2(data)
