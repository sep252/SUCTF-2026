"""Gate failure/success path tests."""

from __future__ import annotations

from author_tools.common import MOD, crc16_ccitt, parse_kv_line, solve_2x2


def poll_until(session, tags, rounds: int = 8):
    for _ in range(rounds):
        lines = session.handle_line("POLL 64")
        for line in lines:
            head, fields = parse_kv_line(line)
            if head == "F" and fields.get("tag") in tags:
                return fields
    raise AssertionError("no target frame found")


def run_trial(session, injections):
    session.handle_line("RESET")
    for lane, value in sorted(injections.items()):
        session.handle_line(f"ENQ INJ {lane} {value}")
    session.handle_line("ENQ ARM")
    session.handle_line("COMMIT")
    return poll_until(session, {"ARM_FAIL", "CHAL"})


def run_pair_trial(session, lane_i, value_i, lane_j, value_j):
    session.handle_line("RESET")
    session.handle_line(f"ENQ INJ {lane_i} {value_i}")
    session.handle_line(f"ENQ INJ {lane_j} {value_j}")
    session.handle_line("ENQ ARM")
    session.handle_line("COMMIT")
    return poll_until(session, {"ARM_FAIL", "CHAL"})


def derive_prove(chal):
    nonce = chal["nonce"]
    p1 = int(chal["sig"]) % MOD
    p2 = int(chal["aux"]) % MOD
    p3 = crc16_ccitt(f"{nonce}:{p1}:{p2}".encode("utf-8"))
    return p1, p2, p3


def test_gate_fail_path(make_session):
    session = make_session(seed="gate-fail-seed")
    session.handle_line("ENQ ARM")
    session.handle_line("COMMIT")
    frame = poll_until(session, {"ARM_FAIL", "CHAL"})
    assert frame["tag"] == "ARM_FAIL"


def test_gate_success_path(make_session):
    session = make_session(seed="gate-success-seed")
    base = run_trial(session, {})
    if base["tag"] == "CHAL":
        p1, p2, p3 = derive_prove(base)
        out = session.handle_line(f"PROVE {p1} {p2} {p3}")[0]
        assert "status=PASS" in out
        return

    chosen = None
    d0 = (0, 0)
    for li in range(9):
        for lj in range(li + 1, 9):
            base2 = run_pair_trial(session, li, 0, lj, 0)
            if base2["tag"] == "CHAL":
                chal = base2
                p1, p2, p3 = derive_prove(chal)
                out = session.handle_line(f"PROVE {p1} {p2} {p3}")[0]
                assert "status=PASS" in out
                return
            d0 = (int(base2["sig"]) % MOD, int(base2["aux"]) % MOD)
            tri = run_pair_trial(session, li, 1, lj, 0)
            trj = run_pair_trial(session, li, 0, lj, 1)
            if tri["tag"] != "ARM_FAIL" or trj["tag"] != "ARM_FAIL":
                continue
            di = (int(tri["sig"]) % MOD, int(tri["aux"]) % MOD)
            dj = (int(trj["sig"]) % MOD, int(trj["aux"]) % MOD)
            ei = ((d0[0] - di[0]) % MOD, (d0[1] - di[1]) % MOD)
            ej = ((d0[0] - dj[0]) % MOD, (d0[1] - dj[1]) % MOD)
            det = (ei[0] * ej[1] - ei[1] * ej[0]) % MOD
            if det != 0:
                chosen = (li, lj, ei, ej, d0)
                break
        if chosen:
            break
    assert chosen is not None

    li, lj, ei, ej, d0 = chosen
    vi, vj = solve_2x2(ei[0], ej[0], ei[1], ej[1], d0[0], d0[1], mod=MOD)
    vi %= MOD
    vj %= MOD

    chal = None
    for _ in range(4):
        got = run_pair_trial(session, li, vi, lj, vj)
        if got["tag"] == "CHAL":
            chal = got
            break
        rd = (int(got["sig"]) % MOD, int(got["aux"]) % MOD)
        c1, c2 = solve_2x2(ei[0], ej[0], ei[1], ej[1], rd[0], rd[1], mod=MOD)
        vi = (vi + c1) % MOD
        vj = (vj + c2) % MOD

    assert chal is not None
    p1, p2, p3 = derive_prove(chal)
    out = session.handle_line(f"PROVE {p1} {p2} {p3}")[0]
    assert "status=PASS" in out
    assert "flag=" in out



