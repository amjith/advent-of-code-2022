import std/[strutils, sequtils, enumerate, algorithm]

type
  Matrix = object
    data: seq[seq[int]]
    rowSize: int
    colSize: int

proc getRow(self: Matrix, row: int): seq[int] =
  self.data[row]

proc getCol(self: Matrix, col: int): seq[int] =
  for row in self.data:
    result.add(row[col])

proc init(self: var Matrix, data: string) =
  for i, line in enumerate(data.splitLines):
    if line.isEmptyOrWhitespace:
      continue
    self.data.add(@[])
    self.data[i].add(line.toSeq.mapIt(parseInt($it)))
  self.rowSize = len(self.data)
  self.colSize = len(self.data[0])

proc isVisible(self: Matrix, row: int, col: int): bool =
  var leftRow: seq[int] = self.getRow(row)[0 ..< col]
  var rightRow: seq[int] = self.getRow(row)[(col+1) .. ^1]
  var topCol: seq[int] = self.getCol(col)[0 ..< row]
  var bottomCol: seq[int] = self.getCol(col)[(row+1) .. ^1]
  return (
    self.data[row][col] > foldl(leftRow, max(a, b), -1) or
    self.data[row][col] > foldl(rightRow, max(a, b), -1) or
    self.data[row][col] > foldl(topCol, max(a, b), -1) or
    self.data[row][col] > foldl(bottomCol, max(a, b), -1)
    )

proc score(item: int, arr: seq[int]): int =
  var score = 0
  for x in arr:
    score += 1
    if x >= item:
      break
  return score

proc visibleScore(self: Matrix, row: int, col: int): int =
  var leftRow: seq[int] = self.getRow(row)[0 ..< col]
  var rightRow: seq[int] = self.getRow(row)[(col+1) .. ^1]
  var topCol: seq[int] = self.getCol(col)[0 ..< row]
  var bottomCol: seq[int] = self.getCol(col)[(row+1) .. ^1]

  return (
    score(self.data[row][col], reversed(leftRow)) * score(self.data[row][col],
        rightRow) * score(self.data[row][col], reversed(topCol)) * score(
        self.data[row][col], bottomCol)
  )


proc part1(data: string): int =
  var matrix: Matrix
  matrix.init(data)
  var visible = 0
  for i in 0 ..< matrix.rowSize:
    for j in 0 ..< matrix.colSize:
      visible += (if matrix.isVisible(i, j): 1 else: 0)
  return visible

proc part2(data: string): int =
  var matrix: Matrix
  matrix.init(data)
  var finalScore = 0
  for i in 0 ..< matrix.rowSize:
    for j in 0 ..< matrix.colSize:
      finalScore = max(finalScore, matrix.visibleScore(i, j))
  return finalScore

let data = readFile("input.txt")
echo part1(data)
echo part2(data)
