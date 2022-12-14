from rich import print
from typing import List, Callable, Tuple, Generator
from dataclasses import dataclass, field

@dataclass
class Monkey:
    items: List[int] = field(default_factory=list)
    operation: str = ""
    divisor: int = 0
    dest_true: int = 0
    dest_false: int = 0
    handle_count: int = 0

    def inspect_and_throw_items(self) -> Generator[Tuple[int, int], None, None]:
        for item in self.items:
            worry = eval(self.operation, {}, {"old": item})
            self.handle_count += 1
            if worry % self.divisor == 0:
                yield worry, self.dest_true
            else:
                yield worry, self.dest_false

def init_monkeys(filename: str):
    monkeys: List[Monkey] = []
    cur_monkey = Monkey()
    for line in open(filename).readlines():
        match line.strip().split(":"):
            case s if s[0].startswith("Monkey"):
                cur_monkey = Monkey()
                monkeys.append(cur_monkey)
            case ["Starting items", rest]:
                cur_monkey.items.extend([int(x) for x in rest.split(", ")])
            case ["Operation", rest]:
                cur_monkey.operation =rest.split("=")[-1].strip() 
            case ["Test", rest]:
                cur_monkey.divisor = int(rest.split()[-1])
            case ["If true", rest]:
                cur_monkey.dest_true = int(rest.split()[-1])
            case ["If false", rest]:
                cur_monkey.dest_false = int(rest.split()[-1])
    return monkeys


def part1(filename) -> int:
    monkeys: List[Monkey] = init_monkeys(filename)
    print(monkeys)
    for _ in range(10000):
        for monkey in monkeys:
            for (item, dest) in monkey.inspect_and_throw_items():
                monkeys[dest].items.append(item)
            monkey.items = []
    results = sorted(monkeys, key=lambda x: x.handle_count, reverse=True)
    return results[0].handle_count * results[1].handle_count  


def part2(filename) -> int:
    monkeys: List[Monkey] = init_monkeys(filename)
    print(monkeys)
    for _ in range(10000):
        for monkey in monkeys:
            for (item, dest) in monkey.inspect_and_throw_items():
                monkeys[dest].items.append(item)
            monkey.items = []
    results = sorted(monkeys, key=lambda x: x.handle_count, reverse=True)
    return results[0].handle_count * results[1].handle_count  

print(part1("small-input.txt"))
print(part2("small-input.txt"))
