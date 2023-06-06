% podzial na specjalne przedzialy skrajne do testowania

le(x0,x2). % 2 minim: x0 i x1
le(x1,x2).
le(x2,x3).
le(x3,x4). % 1 najwiek x4

le(x11,x22). % 1 najmniej x11
le(x22,x33). 
le(x22,x44). % 2 maksy x33 i x44

le(x111,x222). % 2 minim x111 i x222
le(x222,x111). % 2 maksym x111 i x222

le(x1111,x2222). % 1 najwiek


mniejszy(X,Y) :- le(X,Y).
mniejszy(X,Y) :- le(X,Z), mniejszy(Z,Y),!.
wiekszy(X,Y) :- mniejszy(Y,X).
maksymalny(X) :- (le(_,X), \+ le(X,_)); le(X,Y),le(Y,X), le(_,X),le(_,Y).
minimalny(X) :- (le(X,_), \+ le(_,X)); ((le(X,_),le(Y,X),le(X,Y),le(_,Y))).
najwiekszy(X) :- maksymalny(X),\+ (le(Y,X),le(Y,Z),X\=Z), \+ (le(X,Y),le(Y,X)).
najmniejszy(X) :- minimalny(X),\+ (le(X,Y),le(Z,Y),X\=Z), \+ (le(X,Y),le(Y,X)).




