import strutils

proc gameResult(theirMove: string, myMove: string): int =
  case theirMove
    of "A":
      case myMove
        of "X":
          return 3
        of "Y":
          return 6
        of "Z":
          return 0
        else:
          discard
    of "B":
      case myMove
        of "X":
          return 0
        of "Y":
          return 3
        of "Z":
          return 6
        else:
          discard
    of "C":
      case myMove
        of "X":
          return 6
        of "Y":
          return 0
        of "Z":
          return 3
        else:
          discard
    else:
      discard

proc myScore(theirMove: string, myMove: string): int = 
  case myMove
    of "X":
      return (1 + gameResult(theirMove, myMove))
    of "Y":
      return (2 + gameResult(theirMove, myMove))
    of "Z":
      return (3 + gameResult(theirMove, myMove))
    else:
      discard

proc main(): int =
  var totalScore = 0
  for line in "input.txt".lines:
    let moves = split(line)
    totalScore += myScore(moves[0], moves[1])
  return totalScore

echo main()
