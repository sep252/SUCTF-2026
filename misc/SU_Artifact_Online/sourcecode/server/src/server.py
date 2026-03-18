from __future__ import annotations

import hashlib
import os
import pwd
import random
import select
import signal
import string
import subprocess
import sys
import time
from dataclasses import dataclass



POW_DIFFICULTY = 24
POW_TIMEOUT = 60

HL = "\033[30;103m"
GUIDE = "\033[48;5;236m"
RST = "\033[0m"
BOLD = "\033[1m"
RED = "\033[1;31m"
DIM = "\033[2m"


def _check_pow(prefix: str, answer: str, difficulty: int) -> bool:
    h = hashlib.sha256((prefix + answer).encode()).digest()
    bits = int.from_bytes(h[:4], "big")
    return bits >> (32 - difficulty) == 0


def proof_of_work() -> None:
    signal.alarm(POW_TIMEOUT)

    prefix = "".join(random.choices(string.ascii_letters + string.digits, k=16))
    print(f"=== Link Start ===")
    print(f"{BOLD}The artifact seems to require some verification before use.{RST}")
    print(f"sha256(\"{prefix}\" + S).hexdigest()[:{POW_DIFFICULTY // 4}] == \"{'0' * (POW_DIFFICULTY // 4)}\"")
    sys.stdout.flush()

    try:
        answer = input("S: ").strip()
    except (EOFError, KeyboardInterrupt):
        print(f"\n{RED}The artifact emits a sharp crackling sound. You clearly got it wrong.{RST}")
        sys.exit(1)

    if not answer or not _check_pow(prefix, answer, POW_DIFFICULTY):
        print(f"{RED}The artifact emits a sharp crackling sound. You clearly got it wrong.{RST}")
        sys.exit(1)

    print("OK.\n")
    sys.stdout.flush()
    signal.alarm(0)


HALF = 2
COORDS = list(range(-HALF, HALF + 1))
SIZE = len(COORDS)

FACE_NORMALS = {
    "U": (0, 1, 0), "D": (0, -1, 0),
    "L": (-1, 0, 0), "R": (1, 0, 0),
    "F": (0, 0, 1), "B": (0, 0, -1),
}

MOVE_INFO: dict[str, tuple[str, int, int]] = {}
for _i, _layer in enumerate(reversed(COORDS), 1):
    MOVE_INFO[f"R{_i}"] = ("y", _layer, -1)
for _i, _layer in enumerate(COORDS, 1):
    MOVE_INFO[f"C{_i}"] = ("x", _layer, -1)
for _i, _layer in enumerate(reversed(COORDS), 1):
    MOVE_INFO[f"F{_i}"] = ("z", _layer, -1)

ALL_TOKENS = []
for _b in MOVE_INFO:
    ALL_TOKENS.append(_b)
    ALL_TOKENS.append(_b + "'")

CHAR_POOL = ("abcdefgijklmnpqrtuvwxyz,.; " * 6)[:150]
assert CHAR_POOL.count('.') >= 2, f"Need >=2 dots, got {CHAR_POOL.count('.')}"
assert CHAR_POOL.count(';') >= 2, f"Need >=2 semicolons, got {CHAR_POOL.count(';')}"
assert CHAR_POOL.count('?') == 0, "? should not be in pool (wildcard exploit)"
assert CHAR_POOL.count('s') == 0, "s should not be in pool"
assert CHAR_POOL.count('h') == 0, "h should not be in pool"
assert CHAR_POOL.count('o') == 0, "o should not be in pool"
assert CHAR_POOL.count('/') == 0, "/ should not be in pool"

SCRAMBLE = [
    "R1", "C3", "F2", "R4'", "C1", "F5'", "R2", "C4'", "F1",
    "R3'", "C5", "F3", "R5", "C2'", "F4'", "R1'", "C3'", "F2'",
    "R4", "C1'", "F3'", "R2'", "C5'", "F1'", "R5'", "C2", "F4",
    "R3", "C4", "F5",
]


CD_NL_FLAG_PATHS = [
    [(1, 0), (1, 1), (2, 1), (2, 3), (3, 3), (3, 1), (0, 1), (0, 0), (2, 0), (2, 4), (1, 4), (1, 2), (0, 2)],
    [(4, 0), (4, 4), (2, 4), (2, 1), (4, 1), (4, 2), (0, 2), (0, 3), (2, 3), (2, 0), (3, 0), (3, 4), (0, 4)],
    [(2, 0), (2, 4), (4, 4), (4, 3), (1, 3), (1, 2), (4, 2), (4, 1), (1, 1), (1, 0), (0, 0), (0, 4), (1, 4)],
    [(2, 0), (2, 4), (3, 4), (3, 1), (1, 1), (1, 2), (3, 2), (3, 3), (2, 3), (2, 1), (0, 1), (0, 3), (1, 3)],
    [(3, 0), (3, 2), (4, 2), (4, 1), (0, 1), (0, 3), (2, 3), (2, 1), (3, 1), (3, 4), (2, 4), (2, 0), (1, 0)],
    [(1, 0), (1, 4), (4, 4), (4, 2), (0, 2), (0, 4), (2, 4), (2, 3), (1, 3), (1, 1), (3, 1), (3, 0), (4, 0)],
    [(1, 0), (1, 2), (4, 2), (4, 1), (3, 1), (3, 3), (1, 3), (1, 1), (0, 1), (0, 3), (2, 3), (2, 0), (0, 0)],
    [(2, 0), (2, 1), (1, 1), (1, 0), (0, 0), (0, 4), (3, 4), (3, 0), (4, 0), (4, 2), (0, 2), (0, 3), (4, 3)],
    [(1, 0), (1, 4), (0, 4), (0, 1), (1, 1), (1, 3), (3, 3), (3, 4), (2, 4), (2, 0), (4, 0), (4, 1), (3, 1)],
    [(4, 0), (4, 3), (3, 3), (3, 2), (4, 2), (4, 4), (2, 4), (2, 1), (3, 1), (3, 0), (0, 0), (0, 1), (1, 1)],
    [(1, 0), (1, 2), (4, 2), (4, 3), (3, 3), (3, 4), (4, 4), (4, 1), (2, 1), (2, 0), (0, 0), (0, 2), (3, 2)],
    [(2, 0), (2, 4), (3, 4), (3, 2), (1, 2), (1, 3), (2, 3), (2, 1), (0, 1), (0, 2), (4, 2), (4, 0), (3, 0)],
    [(1, 0), (1, 3), (2, 3), (2, 0), (4, 0), (4, 3), (0, 3), (0, 1), (4, 1), (4, 2), (1, 2), (1, 4), (4, 4)],
    [(1, 0), (1, 3), (0, 3), (0, 2), (3, 2), (3, 1), (4, 1), (4, 4), (3, 4), (3, 3), (4, 3), (4, 2), (1, 2)],
    [(3, 0), (3, 2), (0, 2), (0, 3), (2, 3), (2, 1), (4, 1), (4, 3), (1, 3), (1, 1), (3, 1), (3, 4), (1, 4)],
]

LS_PATHS = [
    [(3, 0), (3, 1)],
    [(4, 0), (4, 1)],
    [(4, 0), (4, 2)],
    [(1, 0), (1, 2)],
    [(3, 0), (3, 4)],
    [(1, 0), (1, 1)],
    [(0, 0), (0, 4)],
    [(3, 0), (3, 3)],
    [(2, 0), (2, 4)],
    [(1, 0), (1, 4)],
    [(2, 0), (2, 3)],
    [(1, 0), (1, 3)],
    [(4, 0), (4, 4)],
    [(0, 0), (0, 3)],
    [(2, 0), (2, 1)],
]

EXTRA_MOVES = 20

TIMEOUT = 40
_start_time: float = 0.0


def timer_bar() -> str:
    left = max(0, TIMEOUT - (time.time() - _start_time))
    return f"{DIM}[{left:4.1f}s]{RST}"


RUNE_MAP = {
    'a': '\u16A0', 'b': '\u16A2', 'c': '\u16A6', 'd': '\u16A8', 'e': '\u16B1',
    'f': '\u16B2', 'g': '\u16B7', 'h': '\u16B9', 'i': '\u16BA', 'j': '\u16BE',
    'k': '\u16C1', 'l': '\u16C3', 'm': '\u16C7', 'n': '\u16C8', 'o': '\u16C9',
    'p': '\u16CB', 'q': '\u16CF', 'r': '\u16D2', 's': '\u16D6', 't': '\u16D7',
    'u': '\u16DA', 'v': '\u16DC', 'w': '\u16DF', 'x': '\u16DE', 'y': '\u16E3',
    'z': '\u16E4', ',': '\u16E5', ';': '\u16E6', '.': '\u16E7', ' ': '\u16E8',
    '?': '\u16E9', '{': '\u16AA', '}': '\u16AB', '-': '\u16AC', '"': '\u16AD', '!': '\u16AE', "'": '\u16AF',
}


def to_rune(ch: str) -> str:
    return RUNE_MAP.get(ch, ch)


def to_runes(text: str) -> str:
    return "".join(RUNE_MAP.get(c, c) for c in text)


try:
    _pw = pwd.getpwnam("ctf")
    CTFER_UID = _pw.pw_uid
    CTFER_GID = _pw.pw_gid
except KeyError:
    CTFER_UID = None
    CTFER_GID = None

@dataclass
class Sticker:
    pos: tuple[int, int, int]
    normal: tuple[int, int, int]
    char: str


def rotate_vector(
    vec: tuple[int, int, int], axis: str, quarter_turns: int,
) -> tuple[int, int, int]:
    x, y, z = vec
    for _ in range(quarter_turns % 4):
        if axis == "x":
            x, y, z = x, -z, y
        elif axis == "y":
            x, y, z = z, y, -x
        elif axis == "z":
            x, y, z = -y, x, z
        else:
            raise ValueError(f"Unsupported axis: {axis}")
    return (x, y, z)


class Cube:
    def __init__(self) -> None:
        self.stickers: list[Sticker] = []
        idx = 0
        for face, normal in FACE_NORMALS.items():
            nx, ny, nz = normal
            fc = HALF * (nx + ny + nz)
            for a in COORDS:
                for b in COORDS:
                    if face in ("F", "B"):
                        pos = (a, b, fc)
                    elif face in ("U", "D"):
                        pos = (a, fc, b)
                    else:
                        pos = (fc, b, a)
                    self.stickers.append(
                        Sticker(pos=pos, normal=normal, char=CHAR_POOL[idx])
                    )
                    idx += 1

    def apply_move(self, token: str) -> None:
        base = token[:-1] if token.endswith("'") else token
        axis, layer, bq = MOVE_INFO[base]
        q = -bq if token.endswith("'") else bq
        for s in self.stickers:
            av = {"x": s.pos[0], "y": s.pos[1], "z": s.pos[2]}[axis]
            if av == layer:
                s.pos = rotate_vector(s.pos, axis, q)
                s.normal = rotate_vector(s.normal, axis, q)

    def scramble(self) -> None:
        for m in SCRAMBLE:
            self.apply_move(m)

    def preset_face(self, face_key: str, overrides: dict[tuple[int, int], str]) -> None:
        normal = FACE_NORMALS[face_key]
        for s in self.stickers:
            if s.normal != normal:
                continue
            x, y, z = s.pos
            if face_key == "F":
                col, row = x + HALF, HALF - y
            elif face_key == "R":
                col, row = HALF - z, HALF - y
            elif face_key == "L":
                col, row = z + HALF, HALF - y
            elif face_key == "U":
                col, row = x + HALF, z + HALF
            elif face_key == "D":
                col, row = x + HALF, HALF - z
            else:  # B
                col, row = HALF - x, HALF - y
            if (col, row) in overrides:
                s.char = overrides[(col, row)]

    def front_face(self) -> list[list[str]]:
        grid = [["?"] * SIZE for _ in range(SIZE)]
        for s in self.stickers:
            if s.normal == FACE_NORMALS["F"]:
                x, y, _ = s.pos
                grid[HALF - y][x + HALF] = s.char
        return grid

    def right_face(self) -> list[list[str]]:
        grid = [["?"] * SIZE for _ in range(SIZE)]
        for s in self.stickers:
            if s.normal == FACE_NORMALS["R"]:
                _, y, z = s.pos
                grid[HALF - y][HALF - z] = s.char
        return grid

    def render(self) -> str:
        front, right = self.front_face(), self.right_face()
        lines = ["       [Front]            [Right]   "]
        for fr, rr in zip(front, right):
            frunes = " ".join(f"{to_rune(c):>2s}" for c in fr)
            rrunes = " ".join(f"{to_rune(c):>2s}" for c in rr)
            lines.append(f"    {frunes}  |  {rrunes}")
        return "\n".join(lines)


def clear() -> None:
    sys.stdout.write("\033[2J\033[H")
    sys.stdout.flush()


def _stdin_is_tty() -> bool:
    try:
        return os.isatty(sys.stdin.fileno())
    except Exception:
        return False


if os.name == "nt":
    import msvcrt

    def read_key(timeout: float | None = None) -> str:
        if timeout is not None:
            end = time.time() + timeout
            while not msvcrt.kbhit():
                if time.time() >= end:
                    return ""
                time.sleep(0.05)
        ch = msvcrt.getwch()
        if ch in ("\x00", "\xe0"):
            ch2 = msvcrt.getwch()
            return {"H": "up", "P": "down", "K": "left", "M": "right"}.get(ch2, "")
        if ch == "\r":
            return "enter"
        if ch == "\x1b":
            return "escape"
        if ch == "\x08":
            return "backspace"
        return ch

else:
    def read_key(timeout: float | None = None) -> str:
        fd = sys.stdin.fileno()

        old_settings = None
        if _stdin_is_tty():
            import termios
            import tty
            old_settings = termios.tcgetattr(fd)
            tty.setraw(fd)

        try:
            if timeout is not None:
                ready, _, _ = select.select([fd], [], [], timeout)
                if not ready:
                    return ""

            data = os.read(fd, 1)
            if not data:
                return "escape"

            ch = data[0]

            if ch == 0x1B:  # ESC
                if select.select([fd], [], [], 0.1)[0]:
                    d2 = os.read(fd, 1)
                    if d2 == b"[":
                        if select.select([fd], [], [], 0.1)[0]:
                            d3 = os.read(fd, 1)
                            return {
                                ord("A"): "up", ord("B"): "down",
                                ord("C"): "right", ord("D"): "left",
                            }.get(d3[0], "")
                return "escape"

            if ch in (0x0D, 0x0A):  # \r or \n
                return "enter"
            return chr(ch)
        finally:
            if old_settings is not None:
                import termios
                termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)

def _render_coord_view(
    cube: Cube,
    cx: int, cy: int,
    horizontal: bool,
    cmd_chars: list[str],
) -> str:
    grid = cube.front_face()
    lines: list[str] = []

    lines.append(f"{timer_bar()}  {BOLD}=== Activate ==={RST}")
    arrow = "Horizontal <- ->" if horizontal else "Vertical ^ v"
    lines.append(
        f"Dir: {BOLD}{arrow}{RST}  "
        "Enter=pick  x=activate  q=quit"
    )
    lines.append("")
    lines.append("    " + "".join(f" {c}  " for c in range(SIZE)))

    for r in range(SIZE):
        parts: list[str] = [f" {r}  "]
        for c in range(SIZE):
            rn = f"{to_rune(grid[r][c]):>2s}"
            if r == cy and c == cx:
                parts.append(f"{HL} {rn} {RST}")
            elif (horizontal and r == cy) or (not horizontal and c == cx):
                parts.append(f"{GUIDE} {rn} {RST}")
            else:
                parts.append(f" {rn} ")
        lines.append("".join(parts))

    lines.append("")
    cur = grid[cy][cx]
    lines.append(f"  Cursor: {to_rune(cur)}")

    if cmd_chars:
        spell_display = "".join(to_rune(c) for c in cmd_chars)
        lines.append(f"  Spell: {BOLD}{spell_display}{RST}")
    else:
        lines.append("  Spell: (empty)")

    return "\n".join(lines)


def coord_select_mode(cube: Cube) -> tuple[list[str], bool]:
    cx, cy = 0, 0
    horizontal = True
    cmd_chars: list[str] = []

    while True:
        clear()
        print(_render_coord_view(cube, cx, cy, horizontal, cmd_chars))
        sys.stdout.flush()
        key = read_key(timeout=0.5)

        if not key:
            continue
        if key in ("q", "Q", "escape"):
            return cmd_chars, False
        if key in ("x", "X"):
            return cmd_chars, True

        if key == "enter":
            grid = cube.front_face()
            cmd_chars.append(grid[cy][cx])
            horizontal = not horizontal
            continue

        if horizontal:
            if key == "left":
                cx = (cx - 1) % SIZE
            elif key == "right":
                cx = (cx + 1) % SIZE
        else:
            if key == "up":
                cy = (cy - 1) % SIZE
            elif key == "down":
                cy = (cy + 1) % SIZE

def parse_single_move(raw: str) -> str:
    tokens = raw.strip().split()
    if len(tokens) != 1:
        raise ValueError("one move at a time")
    token = tokens[0].upper()
    base = token[:-1] if token.endswith("'") else token
    if base not in MOVE_INFO:
        raise ValueError("R1-R5 / C1-C5 / F1-F5 (add ' to reverse)")
    return base + ("'" if token.endswith("'") else "")


def move_mode(cube: Cube, move_count: list[int]) -> None:
    print(f"\n{timer_bar()}  {BOLD}--- Twist ---{RST}")
    print(f"R1-R5 / C1-C5 / F1-F5 (add ' to reverse) | q=back\n")
    while True:
        print(cube.render())
        raw = input(f"\nmove> ").strip()
        if raw.lower() in ("q", "quit", "back"):
            return
        if not raw:
            continue
        try:
            move = parse_single_move(raw)
            cube.apply_move(move)
            move_count[0] += 1
        except ValueError as exc:
            print(f"Error: {exc}\n")


FAIL_MSG = f"{RED}The artifact hums briefly, then falls silent.{RST}"


def run_as_ctfer(cmd: str, timeout: int = 3) -> subprocess.CompletedProcess:
    """Run shell command with privilege drop to ctfer user."""
    kw: dict = dict(shell=True, capture_output=True, text=True, timeout=timeout)
    if CTFER_UID is not None:
        kw["user"] = CTFER_UID
        kw["group"] = CTFER_GID
        kw["env"] = {"HOME": "/home/ctf", "PATH": "/usr/local/bin:/usr/bin:/bin", "USER": "ctf"}
        kw["cwd"] = "/home/ctf"
    return subprocess.run(cmd, **kw)


def _timeout_handler(signum, frame):
    print(f"\n{RED}The artifact's glow fades away. It seems you need to reconnect.{RST}")
    sys.stdout.flush()
    sys.exit(1)


def main() -> None:
    proof_of_work()

    signal.signal(signal.SIGALRM, _timeout_handler)
    signal.alarm(TIMEOUT)
    global _start_time
    _start_time = time.time()
    cube = Cube()
    cube.scramble()

    random.seed(int(time.time()))

    cd_sel = random.sample(range(len(CD_NL_FLAG_PATHS)), 2)
    ls_sel = random.sample(range(len(LS_PATHS)), 2)

    faces = random.sample(["F", "R", "U", "B", "L", "D"], 4)

    routes = (
        [("cd ..;nl flag", CD_NL_FLAG_PATHS[i]) for i in cd_sel] +
        [("ls",            LS_PATHS[i])          for i in ls_sel]
    )
    for face, (cmd, path) in zip(faces, routes):
        route = {pos: ch for pos, ch in zip(path, cmd)}
        cube.preset_face(face, route)

    all_chars = [s.char for s in cube.stickers]
    dot_count = all_chars.count('.')
    semi_count = all_chars.count(';')
    assert dot_count >= 2, f"Bug: only {dot_count} dots on cube"
    assert semi_count >= 2, f"Bug: only {semi_count} semicolons on cube"

    if EXTRA_MOVES > 0:
        extra = [random.choice(ALL_TOKENS) for _ in range(EXTRA_MOVES)]
        for m in extra:
            cube.apply_move(m)

    move_count = [0]
    while True:
        clear()
        print(f"{timer_bar()}  {BOLD}A mysterious artifact. Try to find its secret.{RST}")
        print()
        print(cube.render())
        print()
        print("  1 -- Try to twist it")
        print("  2 -- Try to activate it")
        print("  q -- Leave")

        choice = input("\n> ").strip().lower()

        if choice == "1":
            move_mode(cube, move_count)

        elif choice == "2":
            cmd_chars, exec_now = coord_select_mode(cube)
            if not cmd_chars:
                continue
            cmd = "".join(cmd_chars)
            spell = "".join(to_rune(c) for c in cmd)
            clear()
            print(f"Spell: {BOLD}{spell}{RST}")
            print()
            if exec_now or input("Activate? (y/n) > ").strip().lower() == "y":
                try:
                    result = run_as_ctfer(cmd)
                    if result.returncode == 0 and result.stdout:
                        print(f"\n--- activating ---\n")
                        print(to_runes(result.stdout), end="")
                    else:
                        print(f"\n{FAIL_MSG}")
                except Exception:
                    print(f"\n{FAIL_MSG}")
                input("\nPress Enter to continue...")

        elif choice in ("q", "quit", "exit"):
            print("Leave.")
            return


if __name__ == "__main__":
    main()
