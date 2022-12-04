import sets

proc priority(c: char): int =
  if ord(c) - 97 < 0:
    return ord(c) - 64 + 26
  else:
    return ord(c) - 96

proc part1(): int =
  var total_priority = 0
  for line in "input.txt".lines:
    var first = toHashSet(line[0..<line.len div 2])
    var second = toHashSet(line[(line.len div 2)..<line.len])
    for item in first * second:
      total_priority += priority(item)
  return total_priority

echo part1()

iterator findBadge(filename: string, batch_size: int): char =
  let f = open(filename)
  defer: f.close()
  var badge: HashSet[char]
  var line: string
  var count: int = 0
  while f.readLine(line):
    if len(badge) == 0:
      badge = toHashSet(line)
    else:
      badge = badge * toHashSet(line)
    inc count
    if count mod batch_size == 0:
      yield badge.pop
      badge = toHashSet("")


proc part2(): int =
  var badgePriority = 0
  for badge in findBadge("input.txt", 3):
    badgePriority += priority(badge)
  return badgePriority

echo part2()
