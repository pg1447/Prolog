key(read).
key(write).
key(if).
key(then).
key(else).
key(fi).
key(while).
key(do).
key(od).
key(and).
key(or).
key(mod).

int(X):- integer(X), X>=0.

sep(;).
sep(+).
sep(-).
sep(*).
sep(/).
sep('(').
sep(')').
sep(<).
sep(>).
sep(=<).
sep(>=).
sep(:=).
sep(=).
sep(/=).

white(' ').
white('\t').
white('\n').

id(X):- string_chars(X,L), checkId(L).
checkId([]):- !.
checkId([X|L]):-
	char_type(X,alpha),
	char_type(X,upper),
	checkId(L).

readStream(Stream, X):-
	get_char(Stream, C),
	readStream(Stream, C, X).
readStream(_,end_of_file, []):-
	!.
readStream(Stream, C1, X):-
	white(C1),
	!,
	get_char(Stream, C2),
	readStream(Stream, C2, X).
readStream(Stream, C1, [H|T]):-
	(sep(C1);C1=':'),
	!,
	get_char(Stream,C2),
	atom_concat(C1, C2, C3),
	(sep(C3)->
	(
	     H=C3,
	     get_char(Stream,C4),
	     readStream(Stream, C4, T)
	 );
	(
	    H=C1,
	    readStream(Stream, C2, T)
	)).
readStream(Stream, C1, [H|T]):-
	readWord(Stream, C1, C2, '', H),
	readStream(Stream, C2, T).


readWord(_,end_of_file,end_of_file, N, N):-
	!.
readWord(_, C1, C1, N, N):-
	white(C1),!.
readWord(_, C1, C1, N, N):-
	(sep(C1); C1=':'), !.
readWord(Stream, C1, C3, N1, N):-
	atom_concat(N1, C1, N2),
	get_char(Stream, C2),
	readWord(Stream, C2, C3, N2, N).



scanner(Stream, X):-
	readStream(Stream, Y),
	toImper(Y,X).

toImper([], []):-
	!.

toImper([F|R],[T|X]):-
	(
            atom_number(F,Y),
            int(Y),
            T=int(Y),
            toImper(R,X),
	    !
        );
	(
	    sep(F),
	    T=sep(F),
	    toImper(R,X),
	    !
	);
	(
	    key(F),
	    T=key(F),
	    toImper(R,X),
	    !
	);
	(
	    id(F),
	    T=id(F),
	    toImper(R,X)

	);
	toImper(R,[T|X]).




