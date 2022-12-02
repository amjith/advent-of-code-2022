import tables
import strutils


proc score(myMove: string, gameResult: string): int =
  let
    moveScore = {"A": 1, "B": 2, "C": 3}.toTable
    resultScore = {"X": 0, "Y": 3, "Z": 6}.toTable

  return moveScore[myMove] + resultScore[gameResult]


proc pickMyMove(theirMove: string, gameResult: string): string =
  let 
    a = {"X": "C", "Y": "A", "Z": "B"}.toTable
    b = {"X": "A", "Y": "B", "Z": "C"}.toTable
    c = {"X": "B", "Y": "C", "Z": "A"}.toTable

  case theirMove
    of "A":
      return a[gameResult]
    of "B":
      return b[gameResult]
    of "C":
      return c[gameResult]
    else:
      discard


proc main(): int =
  var totalScore = 0
  for line in "input.txt".lines:
    let strategy = split(line)
    totalScore += score(pickMyMove(strategy[0], strategy[1]), strategy[1])
  return totalScore

echo main()
