porownaj(M, X, X) :-
	X > M.
porownaj(M, X, M) :-
	X =< M.

max(L,S):-
	max(L,0,0,S).

max([],M,_,M).
max([X|L],M,T,S):-
	Temp is X+T,
	(Temp < 0 -> max(L,M,0,S);
	(porownaj(Temp,M,Y), max(L,Y,Temp,S))).

