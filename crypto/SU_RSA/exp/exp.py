from sage.all import *
from Crypto.Util.number import long_to_bytes
N = 92365041570462372694496496651667282908316053786471083312533551094859358939662811192309357413068144836081960414672809769129814451275108424713386238306177182140825824252259184919841474891970355752207481543452578432953022195722010812705782306205731767157651271014273754883051030386962308159187190936437331002989
e = 11633089755359155730032854124284730740460545725089199775211869030086463048569466235700655506823303064222805939489197357035944885122664953614035988089509444102297006881388753631007277010431324677648173190960390699105090653811124088765949042560547808833065231166764686483281256406724066581962151811900972309623
S = 19240297841264250428793286039359194954582584333143975177275208231751442091402057804865382456405620130960721382582620473853285822817245042321797974264381440
c = 49076508879433623834318443639845805924702010367241415781597554940403049101497178045621761451552507006243991929325463399667338925714447188113564536460416310188762062899293650186455723696904179965363708611266517356567118662976228548528309585295570466538477670197066337800061504038617109642090869630694149973251

A = N - S + 1
X = 2**338
Y = 2**399
U = X * Y + 1
M = 3
T = 1

PR = PolynomialRing(ZZ, names=("u", "x", "y"))
u, x, y = PR.gens()
Q = PR.quotient(x * y + 1 - u)
f = Q(1 + x * (A + y)).lift()

PR2 = PolynomialRing(ZZ, names=("w", "z"))
w, z = PR2.gens()

shifts = sorted((x**i) * (e ** (M - k)) * (f**k) for k in range(M + 1) for i in range(M - k + 1))
monomials = sorted({mon for poly in shifts for mon in poly.monomials()})


for j in range(1, T + 1):
    for k in range(floor(M / T) * j, M + 1):
        shifts.append(Q((y**j) * (f**k) * (e ** (M - k))).lift())
        monomials.append((u**k) * (y**j))


basis = Matrix(ZZ, len(monomials))
for i, poly in enumerate(shifts):
    basis[i, 0] = poly(0, 0, 0)
    for j in range(1, i + 1):
        mon = monomials[j]
        if mon in poly.monomials():
            basis[i, j] = poly.monomial_coefficient(mon) * mon(U, X, Y)

basis = basis.LLL()
polys = []
for row in basis.rows()[:12]:
    poly = PR(0)
    for coeff, mon in zip(row, monomials):
        if coeff:
            poly += ZZ(coeff // mon(U, X, Y)) * mon
    if poly:
        polys.append(poly)

flag = None
sub_map = {u: w * z + 1, x: w, y: z}


for i in range(len(polys)):
    if flag is not None:
        break
    for j in range(i + 1, len(polys)):
        g1 = PR2(polys[i].subs(sub_map))
        g2 = PR2(polys[j].subs(sub_map))
        if g1.is_constant() or g2.is_constant():
            continue
        res = g1.resultant(g2, z)
        if res == 0 or res.is_constant():
            continue

        roots_w = [ZZ(root) for root, _ in res.univariate_polynomial().change_ring(QQ).roots() if root in ZZ]
        for kw in roots_w:
            if abs(kw) >= X:
                continue
            roots_z = [ZZ(root) for root, _ in g1(w=kw).univariate_polynomial().change_ring(QQ).roots() if root in ZZ]

            for yz in roots_z:
                if abs(yz) >= Y or (1 + kw * (A + yz)) % e != 0:
                    continue
                phi = A + yz
                d = (1 + kw * phi) // e
                s = N - phi + 1
                delta = s * s - 4 * N
                sq = isqrt(delta)
                if sq * sq != delta:
                    continue
                p = (s + sq) // 2
                q = (s - sq) // 2
                print(f"p = {p}")
                print(f"q = {q}")
                if p * q == N:
                    flag = long_to_bytes(pow(c, d, N))
                    break

            if flag is not None:
                break

    if flag is not None:
        break

if flag is None:
    raise ValueError("failed to recover the flag")
print(flag.decode())
# SUCTF{congratulation_you_know_small_d_with_hint_factor}