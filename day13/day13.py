
def check_order(left, right):
    if isinstance(left, int) and not isinstance(right, int):
        if left == right:
            return None
        else:
            return left < right
    if not isinstance(left, list) and isinstance(right, list):
        if len(right) == 0:
            return False
        return check_order(left, right[0])
    if isinstance(left, list) and not isinstance(right, list):
        if len(left) == 0:
            return True
        return check_order(left[0], right)
    for i, _ in enumerate(left):
        if len(right) <= i:  # Right ran out of things. Left is longer (wrong)
            return False
        if isinstance(right[i], list) or isinstance(left[i], list):   # If either one of them is a list, unwrap
            answer = check_order(left[i], right[i])
            if answer is None:
                continue
            else:
                return answer
        elif left[i] > right[i]:
            return False
        elif left[i] < right[i]:
            return True
    if len(left) < len(right):
        return True
    return None


def part1(filename):
    pair_idx = 0
    result = []
    with open(filename) as f:
        for line in  f:
            pair_idx += 1
            left = eval(line)
            right = eval(f.readline().strip())
            _ = f.readline()
            print(pair_idx, "left:", left)
            print(pair_idx, "right:", right)
            if check_order(left, right):
                result.append(pair_idx)
    # print(result)
    return sum(result)


print(part1("input.txt"))
