Perm = list[int]

n = 4
perms = [
    [1,2,3,4],
    [1,2,4,3],
    [1,3,2,4],
    [1,4,2,3],
    [1,4,3,2],
    [2,1,3,4],
    [2,1,4,3],
    [3,1,2,4],
    [3,2,1,4],
    [4,1,2,3],
    [4,1,3,2],
    [4,2,1,3],
    [4,3,1,2],
    [4,3,2,1]
]


def apply(p: Perm, q: Perm) -> Perm:
    return [q[pi - 1] for pi in p]

# def S_rho(q: Perm, u: Perm)

def sig(p: Perm) -> int:
    e = 1
    s = 0

    for x in p:
        s += e * x
        e *= n + 1

    return s

sigs = set(map(sig, perms))
print(len(sigs), len(perms))
print(sigs)

for i, p in enumerate(perms):
    for j, q in enumerate(perms):
        if j < i:
            continue

        r = apply(p, q)
        rsig = sig(r) 

        if rsig not in sigs:
            print(f"NOT CLOSED: {p} * {q} = {r}")

    print("")
