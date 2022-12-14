import std/[sequtils, algorithm]

type opFunc = proc(x: int): int
type testFunc = proc(x: int): int

type
  Monkey = object
    itms: seq[int]
    operation: opFunc
    test: testFunc
    inspectCount: int


#proc part1(data: string): int =
#  var monkeys = @[
#                  Monkey(
#                    itms: @[97, 81, 57, 57, 91, 61],
#                    operation: proc(x: int): int = (x * 7) div 3,
#                    test: proc(x: int): int = (if (x mod 11 == 0): 5 else: 6),
#                    inspectCount: 0),
#                  Monkey(
#                    itms: @[88, 62, 68, 90],
#                    operation: proc(x: int): int = (x * 17) div 3,
#                    test: proc(x: int): int = (if (x mod 19 == 0): 4 else: 2),
#                    inspectCount: 0),
#                  Monkey(
#                    itms: @[74, 87],
#                    operation: proc(x: int): int = (x + 2) div 3,
#                    test: proc(x: int): int = (if (x mod 5 == 0): 7 else: 4),
#                    inspectCount: 0),
#                  Monkey(
#                    itms: @[53, 81, 60, 87, 90, 99, 75],
#                    operation: proc(x: int): int = (x + 1) div 3,
#                    test: proc(x: int): int = (if (x mod 2 == 0): 2 else: 1),
#                    inspectCount: 0),
#                  Monkey(
#                    itms: @[57],
#                    operation: proc(x: int): int = (x + 6) div 3,
#                    test: proc(x: int): int = (if (x mod 13 == 0): 7 else: 0),
#                    inspectCount: 0),
#                  Monkey(
#                    itms: @[54, 84, 91, 55, 59, 72, 75, 70],
#                    operation: proc(x: int): int = (x * x) div 3,
#                    test: proc(x: int): int = (if (x mod 7 == 0): 6 else: 3),
#                    inspectCount: 0),
#                  Monkey(
#                    itms: @[95, 79, 79, 68, 78],
#                    operation: proc(x: int): int = (x + 3) div 3,
#                    test: proc(x: int): int = (if (x mod 3 == 0): 1 else: 3),
#                    inspectCount: 0),
#                  Monkey(
#                    itms: @[61, 97, 67],
#                    operation: proc(x: int): int = (x + 4) div 3,
#                    test: proc(x: int): int = (if (x mod 17 == 0): 0 else: 5),
#                    inspectCount: 0),
#  ]
#  for round in 0..19:
#    for monkey in mitems(monkeys):
#      for itm in mitems(monkey.itms):
#        let worry = monkey.operation(itm)
#        let dest = monkey.test(worry)
#        monkeys[dest].itms.add(worry)
#      monkey.inspectCount += len(monkey.itms)
#      monkey.itms = @[]
#  let inspections = sorted(monkeys.mapIt(it.inspectCount), Descending)
#  return inspections[0] * inspections[1]


proc part2(data: string): int =
  let commonDivisor = 11 * 19 * 5 * 2 * 13 * 7 * 3 * 17;
  var monkeys = @[
                  Monkey(
                    itms: @[97, 81, 57, 57, 91, 61],
                    operation: proc(x: int): int = (x * 7) mod commonDivisor,
                    test: proc(x: int): int = (if (x mod 11 == 0): 5 else: 6),
                    inspectCount: 0),
                  Monkey(
                    itms: @[88, 62, 68, 90],
                    operation: proc(x: int): int = (x * 17) mod commonDivisor,
                    test: proc(x: int): int = (if (x mod 19 == 0): 4 else: 2),
                    inspectCount: 0),
                  Monkey(
                    itms: @[74, 87],
                    operation: proc(x: int): int = (x + 2) mod commonDivisor,
                    test: proc(x: int): int = (if (x mod 5 == 0): 7 else: 4),
                    inspectCount: 0),
                  Monkey(
                    itms: @[53, 81, 60, 87, 90, 99, 75],
                    operation: proc(x: int): int = (x + 1) mod commonDivisor,
                    test: proc(x: int): int = (if (x mod 2 == 0): 2 else: 1),
                    inspectCount: 0),
                  Monkey(
                    itms: @[57],
                    operation: proc(x: int): int = (x + 6) mod commonDivisor,
                    test: proc(x: int): int = (if (x mod 13 == 0): 7 else: 0),
                    inspectCount: 0),
                  Monkey(
                    itms: @[54, 84, 91, 55, 59, 72, 75, 70],
                    operation: proc(x: int): int = (x * x) mod commonDivisor,
                    test: proc(x: int): int = (if (x mod 7 == 0): 6 else: 3),
                    inspectCount: 0),
                  Monkey(
                    itms: @[95, 79, 79, 68, 78],
                    operation: proc(x: int): int = (x + 3) mod commonDivisor,
                    test: proc(x: int): int = (if (x mod 3 == 0): 1 else: 3),
                    inspectCount: 0),
                  Monkey(
                    itms: @[61, 97, 67],
                    operation: proc(x: int): int = (x + 4) mod commonDivisor,
                    test: proc(x: int): int = (if (x mod 17 == 0): 0 else: 5),
                    inspectCount: 0),
  ]
  for round in 0..10000:
    for monkey in mitems(monkeys):
      for itm in mitems(monkey.itms):
        let worry = monkey.operation(itm)
        let dest = monkey.test(worry)
        monkeys[dest].itms.add(worry)
      monkey.inspectCount += len(monkey.itms)
      monkey.itms = @[]
  let inspections = sorted(monkeys.mapIt(it.inspectCount), Descending)
  return inspections[0] * inspections[1]


let data = readFile("small-input.txt")
#data = readFile("input.txt")
echo part2(data)
