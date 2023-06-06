znajdŸ_mniejsz¹([], _, S, S).
znajdŸ_mniejsz¹([G|O], X, S, K) :-
	(   X > G -> T is S + 1 ; T = S),
	znajdŸ_mniejsz¹(O, X, T, K).

iloœæ_inwersji([], S, S).
iloœæ_inwersji([G|O], S, K) :-
	znajdŸ_mniejsz¹(O, G, 0, W),
	T is S + W,
	iloœæ_inwersji(O, T, K).

sprawdŸ_parzystoœæ(L) :-
	iloœæ_inwersji(L, 0, I),
	0 is I mod 2.

even_permutation(Xs, Ys) :-
	permutation(Xs, Ys),
	sprawdŸ_parzystoœæ(Ys).

odd_permutation(Xs, Ys) :-
	permutation(Xs, Ys),
	\+ sprawdŸ_parzystoœæ(Ys).

