from typing import Tuple
from dataclasses import dataclass

def smart_inclusive_range(start, end):
    delta = end - start
    if delta >= 0:
        return range(start, end + 1, 1)
    else:
        return range(start, end - 1, -1)


def make_rocks(line):
    rocks = {}
    coords = [tuple(map(int, coord.split(","))) for coord in line.split("->")]
    for i in range(len(coords) - 1):
        pairs = coords[i : i + 2]
        for x in smart_inclusive_range(pairs[0][0], pairs[1][0]):
            rocks[(x, pairs[0][1])] = "#"
        for y in smart_inclusive_range(pairs[0][1], pairs[1][1]):
            rocks[(pairs[0][0], y)] = "#"
    return rocks

@dataclass
class Sand:
    pos: Tuple[int, int]

    def down(self):
        return self.pos[0], self.pos[1] + 1

    def left_down(self):
        return self.pos[0] -1 , self.pos[1] + 1

    def right_down(self):
        return self.pos[0] +1 , self.pos[1] + 1

    def move(self, obstacles):
        if self.down() not in obstacles:
            self.pos = self.down()
            return True
        if self.left_down() not in obstacles:
            self.pos = self.left_down()
            return True
        if self.right_down() not in obstacles:
            self.pos = self.right_down()
            return True
        return False


def part1(filename):
    obstacles = set()
    for line in open(filename):
        rocks = make_rocks(line)
        obstacles.update(rocks.keys())

    obstacles_begin = len(obstacles)
    start = (500, 0)
    stop = False
    bottom = max(obstacles, key=lambda x: x[1])
    while not stop:
        cur = Sand(start)
        blocked = False
        while not blocked:
            blocked = not cur.move(obstacles)
            if blocked:
                obstacles.add(cur.pos)
            if cur.pos[1] > bottom[1]:
                stop = True
                break
    return (len(obstacles) - obstacles_begin)


def part2(filename):
    obstacles = set()
    for line in open(filename):
        rocks = make_rocks(line)
        obstacles.update(rocks.keys())

    obstacles_begin = len(obstacles)
    start = (500, 0)
    stop = False
    bottom = max(obstacles, key=lambda x: x[1])
    while not stop:
        cur = Sand(start)
        blocked = False
        while not blocked:
            blocked = not cur.move(obstacles)
            if blocked:
                obstacles.add(cur.pos)
            if cur.pos[1] == bottom[1] + 1:
                blocked = True
                obstacles.add(cur.pos)
            if cur.pos == (500, 0):
                stop = True
                obstacles.add(cur.pos)
                break
    return (len(obstacles) - obstacles_begin)

print(part2("input.txt"))
