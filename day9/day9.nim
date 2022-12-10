import std/[strutils, math, sets, sequtils, algorithm]

type
  Point = tuple
    x: int
    y: int

type
  Knots = object
    h: Point
    t: Point

proc updateTail(self: var Knots): Point =
  if abs(self.h.x - self.t.x) > 1 or abs(self.h.y - self.t.y) > 1:
    self.t.x += min(abs(self.h.x - self.t.x), 1) * sgn(self.h.x - self.t.x)
    self.t.y += min(abs(self.h.y - self.t.y), 1) * sgn(self.h.y - self.t.y)
  return self.t


proc move(self: var Knots, direction: string): Point =
  case direction:
    of "R":
      self.h.x += 1
      return updateTail(self)
    of "U":
      self.h.y += 1
      return updateTail(self)
    of "L":
      self.h.x -= 1
      return updateTail(self)
    of "D":
      self.h.y -= 1
      return updateTail(self)
    else:
      raise newException(Exception, "Invalid direction")


proc part1(data: string): int =
  var knots = Knots(h: (0, 0), t: (0, 0))
  var tailPositions: HashSet[Point]
  for line in data.splitLines():
    if line.isEmptyOrWhitespace:
      continue
    let parts = line.split()
    for _ in 1 .. parseInt(parts[1]):
      tailPositions.incl knots.move(parts[0])
      #echo knots
  return len(tailPositions)


proc part2(data: string): int = 
  var knots: array[10, Knots]
  var tailPositions: HashSet[Point]
  for i in 0 .. 9:
    knots[i] = Knots(h: (0, 0), t: (0, 0))

  for line in data.splitLines:
    echo line
    #echo knots
    if line.isEmptyOrWhitespace:
      continue
    let parts = line.split()
    for _ in 1 .. parseInt(parts[1]):
      var position = knots[0].move(parts[0])
      for i in 1 .. 9:
        knots[i].h = position
        if i == 9:
          tailPositions.incl(position)
        position = knots[i].updateTail
    #for i, v in pairs(knots):
      #echo i, v
  #echo sorted(toSeq(tailPositions))
  return len(tailPositions)



#let data = readFile("small-input.txt")
#let data = readFile("med-input.txt")
let data = readFile("input.txt")
#echo part1(data)
echo part2(data)
