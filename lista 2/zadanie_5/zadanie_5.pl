.lista(N,X):-length(X,K),K=:=N*2,(between(1,N,A),(dwukrotnie(A,X),parzystosc(A,X))).


jednokrotnie(X,L):-member(X,L),(select(X,L,L1),\+(member(X,L1))),!.


dwukrotnie(X,L):-L3=[X|_],append(L2,L3,L),jednokrotnie(X,L2),jednokrotnie(X,L3).
parzystosc(A,X):-L=[A|_],L=[_|A],append(_,L,X),append(L,_,X).
