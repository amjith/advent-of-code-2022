import std/[strutils, sequtils, tables, algorithm]

type
  ElfFile = object
    name: string
    size: int

type
  ElfDir = ref object
    parent: ElfDir
    name: string
    files: Table[string, ElfFile]
    dirs: Table[string, ElfDir]

proc size(self: ElfDir): int =
  var fileTotal = 0
  for file in self.files.values:
    fileTotal += file.size
  var dirTotal = 0
  for dir in self.dirs.values:
    dirTotal += dir.size
  return fileTotal + dirTotal

proc buildTree(data: string): ElfDir =
  var curDir: ElfDir
  var rootDir: ElfDir
  for line in data.splitLines:
    if line == "":
      continue
    let parts = line.split()
    if parts[0] == "$":
      if parts[1] == "cd":
        if parts[2] == "..":
          curDir = curDir.parent
        else:
          if curDir == nil:
            rootDir = ElfDir(name: parts[2], parent: nil)
            curDir = rootDir
          else:
            curDir = curDir.dirs[parts[2]]
    else:
      if parts[0] == "dir":
        curDir.dirs[parts[1]] = ElfDir(name: parts[1], parent: curDir)
      else:
        curDir.files[parts[1]] = ElfFile(name: parts[1], size: parseInt(parts[0]))
  return rootDir

proc sizeTotal(cur: ElfDir, limit: int): int = 
  var toVisit: seq[ElfDir]
  var total = 0
  toVisit.add(cur)
  while len(toVisit) > 0:
    var visiting = toVisit.pop
    if visiting.size < limit:
      total += visiting.size
    toVisit.add(toSeq(visiting.dirs.values))
  return total

proc dirSizes(cur: ElfDir): seq[int] =
  var toVisit: seq[ElfDir]
  var sizes: seq[int]
  toVisit.add(cur)
  while len(toVisit) > 0:
    var visiting = toVisit.pop
    sizes.add(visiting.size)
    toVisit.add(toSeq(visiting.dirs.values))
  return sizes


proc part1(data: string) = 
  var tree = buildTree(data)
  echo sizeTotal(tree, 100000)

proc part2(data: string): int = 
  var tree = buildTree(data)
  var sizes: seq[int] = dirSizes(tree)
  var occupiedSize = max(sizes)
  var freeSpace = 70000000 - occupiedSize
  var requiredSpace = 30000000 - freeSpace
  sizes.sort()
  for size in sizes:
    if size >= requiredSpace:
      return size


let data = readFile("input.txt")
part1(data)
echo part2(data)
