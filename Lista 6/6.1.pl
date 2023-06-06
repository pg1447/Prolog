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
sep('%').

white(' ').
white('\t').
white('\n').

id(X):- atom_chars(X,L), checkId(L).
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


program(P) --> program([], P).
program(X,X) --> [].
program(L,P) --> instrukcja(X), {append(L,[X],Y)}, program(Y,P).

instrukcja(read(X)) --> [key(read), id(X), sep(;)].
instrukcja(write(X)) --> [key(write)], nawiaswyrazenie(X), [sep(;)].
instrukcja(assign(I, W)) --> [id(I), sep(:=)], nawiaswyrazenie(W), [sep(;)].
instrukcja(if(W,P)) --> [key(if)], nawiaswarunki(W), [key(then)], program(P), [key(fi), sep(;)].
instrukcja(if(W,P1,P2)) --> [key(if)], nawiaswarunki(W), [key(then)], program(P1), [key(else)], program(P2), [key(fi), sep(;)].
instrukcja(while(W,P1)) --> [key(while)], nawiaswarunki(W), [key(do)], program(P1), [key(od), sep(;)].


czynnik(int(W)) --> [int(W)].
czynnik(id(W)) --> [id(W)].

nawiaswyrazenie(W) --> wyrazenie(W).
nawiaswyrazenie(( W )) --> [sep('(')], nawiaswyrazenie(W), [sep(')')].
nawiaswyrazenie((W1) + W2) --> [sep('(')], nawiaswyrazenie(W1),[sep(')'), sep(+)], nawiaswyrazenie(W2).
nawiaswyrazenie((W1) - W2) --> [sep('(')], nawiaswyrazenie(W1),[sep(')'), sep(-)], nawiaswyrazenie(W2).
nawiaswyrazenie((W1) * W2) --> [sep('(')], nawiaswyrazenie(W1),[sep(')'), sep(*)], nawiaswyrazenie(W2).
nawiaswyrazenie((W1) / W2) --> [sep('(')], nawiaswyrazenie(W1),[sep(')'), sep(/)], nawiaswyrazenie(W2).
nawiaswyrazenie((W1) mod W2) --> [sep('(')], nawiaswyrazenie(W1),[sep(')'), sep('%')], nawiaswyrazenie(W2).
nawiaswyrazenie((W1) mod W2) --> [sep('(')], nawiaswyrazenie(W1),[sep(')'), key(mod)], nawiaswyrazenie(W2).

wyrazenie(W) --> skladnik(W).
wyrazenie(W1 + W2) --> skladnik(W1), [sep(+)], nawiaswyrazenie(W2).
wyrazenie(W1 - W2) --> skladnik(W1), [sep(-)], nawiaswyrazenie(W2).

skladnik(W) --> czynnik(W).
skladnik(W1 * W2) --> czynnik(W1), [sep(*)], nawiaswyrazenie(W2).
skladnik(W1 / W2) --> czynnik(W1), [sep(/)], nawiaswyrazenie(W2).
skladnik(W1 mod W2) --> czynnik(W1), [sep('%')], nawiaswyrazenie(W2).
skladnik(W1 mod W2) --> czynnik(W1), [key(mod)], nawiaswyrazenie(W2).


nawiaswarunki(W) --> warunki(W).
nawiaswarunki((W)) --> [sep('(')], nawiaswarunki(W), [sep(')')].
nawiaswarunki((W1) ',' W2) --> [sep('(')], nawiaswarunki(W1), [sep(')'), key(and)], nawiaswarunki(W2).
nawiaswarunki((W1) ; W2) --> [sep('(')], nawiaswarunki(W1), [sep(')'), key(or)], nawiaswarunki(W2).

warunki(W1 ',' W2) --> warunek(W1), [key(and)], nawiaswarunki(W2).
warunki(W1 ; W2) --> warunek(W1), [key(or)], nawiaswarunki(W2).
warunki(W) --> warunek(W).


warunek(W1 =:= W2) --> wyrazenie(W1), [sep(=)], wyrazenie(W2).
warunek(W1 =\= W2) --> wyrazenie(W1), [sep(\=)], wyrazenie(W2).
warunek(W1 >= W2) --> wyrazenie(W1), [sep(>=)], wyrazenie(W2).
warunek(W1 =< W2) --> wyrazenie(W1), [sep(=<)], wyrazenie(W2).
warunek(W1 < W2) --> wyrazenie(W1), [sep(<)], wyrazenie(W2).
warunek(W1 > W2) --> wyrazenie(W1), [sep(>)], wyrazenie(W2).



podstaw([] , ID, N, [ID=N]).
podstaw([ID=_|AS], ID, N, [ID=N|AS]) :- !.
podstaw([ID1=W1|AS1], ID, N, [ID1=W1|AS2]) :-
	podstaw(AS1, ID, N, AS2).

pobierz([ID=N|_], ID, N) :- !.
pobierz([_|AS], ID, N) :-
	pobierz(AS, ID, N).

wartosc(int(N), _, N).
wartosc(id(ID), AS, N) :-
	pobierz(AS, ID, N).
wartosc(W1 + W2, AS, N) :-
	wartosc(W1, AS, N1), wartosc(W2, AS, N2),
	N is N1 + N2.
wartosc(W1 - W2, AS, N) :-
	wartosc(W1, AS, N1), wartosc(W2,AS,N2),
	N is N1 - N2.
wartosc(W1 * W2, AS, N) :-
	wartosc(W1,AS,N1), wartosc(W2, AS, N2),
	N is N1 * N2.
wartosc(W1 / W2, AS, N) :-
	wartosc(W1, AS, N1), wartosc(W2, AS, N2),
	N2 =\= 0, N is N1 div N2.
wartosc(W1 mod W2, AS, N) :-
	wartosc(W1, AS, N1), wartosc(W2,AS,N2),
	N2 =\= 0, N is N1 mod N2.

prawda(W1 =:= W2, AS) :-
	wartosc(W1, AS, N1), wartosc(W2, AS, N2),
	N1 =:= N2.
prawda(W1 =\= W2, AS) :-
	wartosc(W1, AS, N1), wartosc(W2, AS, N2),
	N1 =\= N2.
prawda(W1 < W2, AS) :-
	wartosc(W1, AS, N1), wartosc(W2, AS, N2),
	N1 < N2.
prawda(W1>W2, AS) :-
	wartosc(W1, AS, N1), wartosc(W2, AS, N2),
	N1>N2.
prawda(W1 >= W2, AS) :-
	wartosc(W1, AS, N1), wartosc(W2, AS, N2),
	N1 >= N2.
prawda(W1 =< W2, AS) :-
	wartosc(W1, AS, N1), wartosc(W2, AS, N2),
	N1 =< N2.
prawda((W1, W2), AS) :-
	prawda(W1, AS),
	prawda(W2, AS).
prawda((W1; W2), AS) :-
       (   prawda(W1, AS),
	   !
       ;   prawda(W2, AS)).

interpreter([], _).
interpreter([read(ID) | PGM], AS) :- !,
	read(N),
	integer(N),
	podstaw(AS, ID, N, AS1),
	interpreter(PGM, AS1).
interpreter([write(W) | PGM], AS) :- !,
	wartosc(W, AS, WART),
	write(WART), nl,
	interpreter(PGM, AS).
interpreter([assign(ID, W) | PGM], AS) :- !,
	wartosc(W, AS, WAR),
	podstaw(AS, ID, WAR, AS1),
	interpreter(PGM, AS1).
interpreter([if(C, P) | PGM], AS) :- !,
	interpreter([if(C, P, []) | PGM], AS).
interpreter([if(C, P1, P2) | PGM], AS) :- !,
	(   prawda(C, AS)
	->  append(P1, PGM, DALEJ)
	;   append(P2, PGM, DALEJ)),
	interpreter(DALEJ, AS).
interpreter([while(C,P) | PGM], AS) :- !,
	append(P, [while(C,P)], DALEJ),
	interpreter([if(C, DALEJ) | PGM], AS).


interpreter(PROGRAM) :-
	interpreter(PROGRAM, []).



wykonaj(NAZWA_PLIKU) :-
	open(NAZWA_PLIKU, read, X),
	scanner(X, Y), close(X),
	phrase(program(PROGRAM), Y),
	interpreter(PROGRAM).
