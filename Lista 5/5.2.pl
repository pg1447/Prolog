hetmany(N, P) :-
	numlist(1, N, L),
	perm(L, P),
	dobra(P).

perm([], []).
perm(L1, [X | L3]) :-
	select(X, L1, L2),
	perm(L2, L3).

dobra(X) :-
	\+ zla(X).

zla(X) :-
	append(_, [Wi | L1], X),
	append(L2, [Wj | _], L1),
	length(L2, K),
	abs(Wi - Wj) =:= K+1.


test(X,Z,Y):-
	append(T1,[X|_],Y),
	length(T1,Z).

board(X):-
       length(X,Y),
       plansza(Y,X).


plansza(N,L):-
	X is N mod 2,
	X =:= 0 -> plansza2(N,N,L);plansza1(N,N,L).

plansza1(N,T,L):-
	T>0 ->
	(
	      A is T,
	      append(X,[A|_],L),
	      length(X,Z),
	      linia1(N,Z),
	      plansza2(N,T-1,L)
	);
	kreski(N).

plansza2(N,T,L):-
	T>0->
	(	A is T,
	        append(X,[A|_],L),
		length(X,Z),
		linia2(N,Z),
		plansza1(N,T-1,L)
	);
	kreski(N).

linia2(N,X):-
	kreski(N),
	pola2(N,X),
	pola2(N,X).


linia1(N,X):-
	kreski(N),
	pola1(N,X),
	pola1(N,X).

pola1(N,X):-
	X=:=0 -> (hetmanczarne, pola2(N-1));
	(czarne, pola2(N-1,X-1)).

pola2(N,X):-
	X=:=0 -> (hetmanbiale, pola1(N-1));
	(biale, pola1(N-1,X-1)).

pola1(N):- N>0 ->
	(czarne, pola2(N-1));
	write('|\n').
pola2(N):- N>0 ->
	(biale, pola1(N-1));
	write('|\n').
hetmanczarne:-write('|:###:').
hetmanbiale:-write('| ### ').
czarne:-write('|:::::').
biale:-write('|'),tab(5).


kreski(N):-kreska(N);write('+\n').
kreska(N):-N > 0,write('+-----'), kreska(N-1).
