znajd�_mniejsz�([], _, S, S).
znajd�_mniejsz�([G|O], X, S, K) :-
	(   X > G -> T is S + 1 ; T = S),
	znajd�_mniejsz�(O, X, T, K).

ilo��_inwersji([], S, S).
ilo��_inwersji([G|O], S, K) :-
	znajd�_mniejsz�(O, G, 0, W),
	T is S + W,
	ilo��_inwersji(O, T, K).

sprawd�_parzysto��(L) :-
	ilo��_inwersji(L, 0, I),
	0 is I mod 2.

even_permutation(Xs, Ys) :-
	permutation(Xs, Ys),
	sprawd�_parzysto��(Ys).

odd_permutation(Xs, Ys) :-
	permutation(Xs, Ys),
	\+ sprawd�_parzysto��(Ys).

