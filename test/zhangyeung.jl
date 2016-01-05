n = 4
G = polymatroidcone(n)

# Basic tests
@test matusrentropy(1, 14) in G
@test matusrentropy(1, 23) in G
@test matusrentropy(1, 24) in G
@test matusrentropy(2, 3) in G
@test matusrentropy(2, 4) in G

# This vector is not entropic
invalidf = invalidfentropy(12)
# but it is a polymatroid
@test invalidf in G

I = set(1)
J = set(2)
K = set(3)
L = set(4)
zhangyeungineq = 3(nonnegative(n,union(I,K)) + nonnegative(n,union(I,L)) + nonnegative(n,union(K,L))) +
                nonnegative(n,union(J,K)) + nonnegative(n,union(J,L)) -
                (nonnegative(n,I) + 2(nonnegative(n,K) + nonnegative(n,L)) + nonnegative(n,union(I,J)) +
                4nonnegative(n,union(I,union(K,L))) + nonnegative(n,union(J,union(K,L))))
# Alternative expression
@test zhangyeunginequality() == zhangyeungineq

# The Zhang-Yeung inequality is a new inequality
@test !(zhangyeungineq in G)
# And it see that invalidf is not entropy
@test dot(zhangyeungineq, invalidf) == -1

# FIXME it should be invalidfentropy(12)
#       what is returned by CDD is not even a certificate.
#       it seems to be a bug in cddlib
println(redundant(zhangyeungineq, G)[2])
