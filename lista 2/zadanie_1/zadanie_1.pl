nieparzyste(L) :- length(L,X), X mod 2=\=0.
srodkowy(L,X) :- nieparzyste(L), (append(L1,L2,L), length(L1,X1),length(L2,X2), Z is X2-1,Z=:=X1, L2=[X|_]).
