from functools import cmp_to_key


def check_order(left, right):
    if isinstance(left, int) and isinstance(right, int):
        if left == right:
            return None
        else:
            return -1 if left < right else 1
    if isinstance(left, list) and isinstance(right, list):
        ans = None
        for l, r in zip(left, right):
            ans = check_order(l, r)
            if ans is None:
                continue
            else:
                return ans
        if len(left) == len(right):
            return ans
        else:
            return -1 if len(left) < len(right) else 1
    if isinstance(left, int) and isinstance(right, list):
        return check_order([left], right)
    if isinstance(left, list) and isinstance(right, int):
        return check_order(left, [right])


def part2(filename):
    packets = []
    with open(filename) as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            packets.append(eval(line))
    packets.append([[2]])
    packets.append([[6]])
    results = sorted(packets, key=cmp_to_key(check_order))
    return (results.index([[2]]) + 1) * (results.index([[6]]) + 1)


def part1(filename):
    pair_idx = 0
    result = []
    with open(filename) as f:
        for line in f:
            pair_idx += 1
            left = eval(line)
            right = eval(f.readline().strip())
            _ = f.readline()
            # print(pair_idx, "left:", left)
            # print(pair_idx, "right:", right)
            if check_order(left, right) == -1:
                result.append(pair_idx)
    print(result)
    return sum(result)


print(part1("input.txt"))
print(part2("input.txt"))
