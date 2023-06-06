zapalki(N,(srednie(Y),male(Z))):-
	generuj(N,(duze(0),srednie(Y),male(Z))).
zapalki(N,(duze(X),srednie(Y))):-
	generuj(N,(duze(X),srednie(Y),male(0))).
zapalki(N,(duze(X),male(Z))):-
	generuj(N,(duze(X),srednie(0),male(Z))).
zapalki(N,(duze(X))):-
	generuj(N,(duze(X),srednie(0),male(0))).
zapalki(N,(srednie(Y))):-
	generuj(N,(duze(0),srednie(Y),male(0))).
zapalki(N,(male(Z))):-
	generuj(N,(duze(0),srednie(0),male(Z))).
zapalki(N,(duze(X),srednie(Y),male(Z))):-
	generuj(N,(duze(X),srednie(Y),male(Z))).

generuj(N,(duze(X),srednie(Y),male(Z))):-
	gen_duz(X,Wynik), gen_sre(Y,Wynik,Wynik2), gen_mal(Z,Wynik2, Wynik3), length(Wynik3,Z1), N is 24 - Z1,
	rysuj(Wynik3).

rysuj(X):-
	linia1(X,0),
	linia2(X,0),
	linia1(X,1),
	linia2(X,1),
	linia1(X,2),
	linia2(X,2),
	linia1(X,3),
	nl.

linia2(X,N):-
	A is 12+N, B is 15+N, C is 18+N, D is 21 + N,
	(   member(A,X) -> write('|');tab(1)),
	tab(3),
	(   member(B,X) -> write('|');tab(1)),
	tab(3),
	(   member(C,X) -> write('|');tab(1)),
	tab(3),
	(   member(D,X) -> write('|');tab(1)),
	tab(3),nl.

linia1(X,N):-
	write('+'),
	A is N*3, B is N*3+1, C is N*3+2,
	(   member(A,X) -> write('---');tab(3)),
	write('+'),
	(   member(B,X) -> write('---');tab(3)),
	write('+'),
	(   member(C,X) -> write('---');tab(3)),
	write('+'),nl.

spr_duze(Old, New):-
	Duzy=[0,1,2,9,10,11,12,13,14,21,22,23],
	(intersection(Duzy,Old,Duzy) -> true; \+ intersection(Duzy,New,Duzy)).

spr_sre(Old, New):-
	Sr=[[0,1,6,7,12,13,18,19],[1,2,7,8,15,16,21,22],[3,4,9,10,13,14,19,20],[4,5,10,11,16,17,22,23]],
	\+ (select(X,Sr,_), (union(X,Old,Old) -> false; union(X,New,New))).

gen_duz(0,[]).
gen_duz(1,Wynik):-
	Wynik=[0,1,2,9,10,11,12,13,14,21,22,23].

gen_sre(N,Tab,Wynik):-
       Sr=[[0,1,6,7,12,13,18,19],[1,2,7,8,15,16,21,22],[3,4,9,10,13,14,19,20],[4,5,10,11,16,17,22,23]],
       gen_sre(N,Tab,Sr,Wynik).

gen_sre(X,Tab,_,Tab):-X=:=0,!.
gen_sre(N,Tab,[X|Rest],Wynik):-
	union(X,Tab,Y),spr_duze(Tab,Y), gen_sre(N-1,Y,Rest,Wynik).
gen_sre(N,Tab,[_|Rest],Wynik):-
	gen_sre(N,Tab,Rest,Wynik).


licz_mal(Tab, Wynik):-
	Ml=[[0,3,12,15],[1,4,15,18],[2,5,18,21],[3,6,13,16],[4,7,16,19],[5,8,19,22],[6,9,14,17],[7,10,17,20],[8,11,20,23]],
	licz_mal(Tab,Ml,Ml,Wynik).
licz_mal(_,[], W, W).
licz_mal(Tab, [X|Rest], Y, W):-
	(   union(X,Tab,Tab) ->(select(X,Y,Y1), licz_mal(Tab, Rest, Y1, W)); licz_mal(Tab,Rest,Y,W)).

gen_mal(N,Tab,Wynik):-
	licz_mal(Tab, W),
	gen_mal(N, Tab, W, Wynik).

gen_mal(N, Tab, _, Wynik):-
	licz_mal(Tab,Z), length(Z,X), N =:= 9-X, Wynik = Tab,!.

gen_mal(N, Tab, [X|Rest], Wynik):-
	union(X,Tab,Y), spr_duze(Tab,Y), spr_sre(Tab,Y), gen_mal(N,Y,Rest,Wynik).
gen_mal(N, Tab, [_|Rest], Wynik):-
	gen_mal(N,Tab,Rest,Wynik).
