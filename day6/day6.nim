import sets

func main(data: string, uniqueCount: int): int =
  for i in 0 ..< data.len:
    if len(toHashSet(data[i..i+uniqueCount - 1])) == uniqueCount:
      return i+uniqueCount

let data = readFile("input.txt")
echo main(data, 4)
echo main(data, 14)
