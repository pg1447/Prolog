in(X,Y,N):-
	X=..[_|[Y|N]].

browse(X):-browse(X,[],[]).
browse(X,P,N):-
	write(X),nl,write('command  : '),
	read(Y),
	(
	    (
	        Y = i, in(X,Z,N1), browse(Z,[],N1)
	    );
	    (
	        Y = o, !, false
	    );
	    (
		Y = n, N=[N1|N2],! ,browse(N1,[X|P],N2)
	    );
	    (
		Y = p, P=[P1|P2],! ,browse(P1,P2,[X|N])
	    );
	    browse(X,P,N)
	).
