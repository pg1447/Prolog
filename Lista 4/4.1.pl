wyrazenie(X,Y,Z):-
	dzialanie(X,Z),
	W is Z,
	Y = W.



dzialanie([X],X).

dzialanie(L,W):-
	append(X,Y,L),
	X \= [], Y \= [],
	dzialanie(X,Z1),
	dzialanie(Y,Z2),
	(
	W = Z1+Z2;
	W = Z1-Z2;
	W = Z1*Z2;
	(Z2 =\= 0 ,W=Z1/Z2)
	).

/*
dzialanie([X|Rest],Y):-
	dzialanie(Rest,Y1),
	(
	Y = X+Y1;
	Y = X-Y1;
	Y = X*Y1;
	(Z is Y1, Z =\=0, Y = X/Y1)
	).
*/
