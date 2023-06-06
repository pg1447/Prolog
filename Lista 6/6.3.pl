g1 --> [].
g1 --> [ a ], g1, [ b ].

g2 --> n(N, a), n(N, b), n(N, c).
n(N, C) --> [ C ], n(N2, C), {N is N2+1}.
n(0, _) --> [].

g3 --> n(N, a), {fibo(N, F), !}, n(F, b).

fibo(0, 0).
fibo(1, 1).
fibo(N, F) :- A1 is N-1, A2 is N-2, fibo(A1, F1), fibo(A2, F2), F is F1+F2.


p([]) --> [].
p([X|Xs]) --> [X], p(Xs).
