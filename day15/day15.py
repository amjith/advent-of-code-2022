from functools import total_ordering
from typing import Tuple
from dataclasses import dataclass
from itertools import chain


def distance(p1: Tuple[int, int], p2: Tuple[int, int]) -> int:
    return abs(p1[0] - p2[0]) + abs(p1[1] - p2[1])


@total_ordering
@dataclass
class Sensor:
    def __init__(self, pos: Tuple[int, int], beacon: Tuple[int, int]):
        self.pos = pos
        self.beacon = beacon
        self.beacon_distance = distance(self.pos, self.beacon)

    def __lt__(self, other):
        return self.pos < other.pos

    def __eq__(self, other):
        return self.pos == other.pos

    def in_reach(self, row):
        return self.pos[1] - self.beacon_distance <= row <= self.pos[1] + self.beacon_distance

    def reach(self, row):
        if not self.in_reach(row):
            return (self.pos[0], self.pos[0])

        r = abs(self.beacon_distance - abs(self.pos[1] - row))
        # return range(self.pos[0] - r, self.pos[0] + r + 1)
        return (self.pos[0] - r, self.pos[0] + r + 1)


def part1(filename, row=10):
    sensors = {}
    beacons = set()
    for line in open(filename):
        parts = line.split()
        p1 = (int(parts[2].split("=")[1][:-1]), int(parts[3].split("=")[1][:-1]))
        p2 = (int(parts[8].split("=")[1][:-1]), int(parts[9].split("=")[1]))
        sensors[p1] = Sensor(pos=p1, beacon=p2)
        beacons.add(p2)
    reach = set(chain(*(sensor.reach(row) for sensor in sensors.values())))
    return len(reach)


def merge_intervals(intervals):
    intervals.sort()
    final_intervals = [intervals[0]]
    for interval in intervals:
        if final_intervals[-1][0] <= interval[0] <= final_intervals[-1][1] - 1:
            final_intervals[-1] = (final_intervals[-1][0], max(final_intervals[-1][1], interval[1]))
        else:
            final_intervals.append(interval)
    return final_intervals


def part2(filename, size=4000000):
    sensors = {}
    beacons = set()
    for line in open(filename):
        parts = line.split()
        p1 = (int(parts[2].split("=")[1][:-1]), int(parts[3].split("=")[1][:-1]))
        p2 = (int(parts[8].split("=")[1][:-1]), int(parts[9].split("=")[1]))
        sensors[p1] = Sensor(pos=p1, beacon=p2)
        beacons.add(p2)

    total_set = set(range(size))
    for row in range(size):
        intervals = [sensor.reach(row) for sensor in sensors.values()]
        merged_intervals = merge_intervals(intervals)
        if len(merged_intervals) > 1:
            return total_set - {x for interval in merged_intervals for x in range(interval[0], interval[1])}, row


# print(part1("small-input.txt", row=10))
# print(part1("input.txt", row=2000000))
# print(part2("small-input.txt", size=20))
print(part2("input.txt", size=4000000))
