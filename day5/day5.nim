import std/[strutils, re, sequtils]

type
  Movement = object
    src: int
    dest: int
    numBoxes: int

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

proc bulkAdd(self: var Stack, boxes: seq[char]) =
  self.boxes.add(boxes)

proc bulkRemove(self: var Stack, num: int): seq[char] =
  let 
    startIdx = self.boxes.len - num
    endIdx = self.boxes.len - 1
  let result = self.boxes[startIdx .. endIdx]
  self.boxes.delete(startIdx .. endIdx)
  return result

proc top(self: Stack): char = return self.boxes[^1]


type
  CargoShip = object
    stacks: seq[Stack]

proc add(self: var CargoShip, stack: int, box: char, append: bool) = 
  if self.stacks.len - 1 < stack:
    self.stacks.add(Stack())
  self.stacks[stack].add(box, append)

proc remove(self: var CargoShip, stack: int): char = self.stacks[stack].remove

proc move(self: var CargoShip, src: int, dest: int, num: int) =
  for _ in 0 ..< num:
    let box = self.remove(src)
    self.add(dest, box, true)

proc bulkMove(self: var CargoShip, src: int, dest: int, num: int) = 
    let boxes = self.stacks[src].bulkRemove(num)
    self.stacks[dest].bulkAdd(boxes)


proc top(self: CargoShip): string = self.stacks.map(top).join


func parseMovements(data: string): seq[Movement] =
  let rexp = re"move (\d+) from (\d+) to (\d+)"
  var movements: seq[Movement]
  for line in data.splitLines:
    var matches: array[3, string]
    if match(line, rexp, matches):
      movements.add(Movement(src: parseInt(matches[1]) - 1, dest: parseInt(matches[
          2]) - 1, numBoxes: parseInt(matches[0])))
  return movements

proc buildCargoShip(data: string): CargoShip =
  var cargoShip: CargoShip
  for line in data.splitLines:
    if len(line) == 0:
      return cargoShip
    let stackCount = (line.len + 2) div 4
    for stack in 0 ..< stackCount:
      let box = line[stack * 4 + 1]
      cargoShip.add(stack, box, false)

proc part1(data: string): string =
  var cargo = buildCargoShip(data)
  let movements = parseMovements(data)
  for movement in movements:
    cargo.move(movement.src, movement.dest, movement.numBoxes)
  return cargo.top


proc part2(data: string): string =
  var cargo = buildCargoShip(data)
  let movements = parseMovements(data)
  for movement in movements:
    cargo.bulkMove(movement.src, movement.dest, movement.numBoxes)
  return cargo.top


let data = readFile("input.txt")
echo part1(data)
echo part2(data)
