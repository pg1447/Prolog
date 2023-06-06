wariancja(L,X):-
	sum(L,S),
	length(L,N),
	wariancja(L,N,S,X1),
	X is X1/N.

sum([],0).
sum([X|L],S):-
	sum(L,S1),
	S is X+S1.

wariancja([],_,_,0).
wariancja([X|L],N,S,V):-
	wariancja(L,N,S,V1),
	V is ((X-S/N)*(X-S/N))+V1.


