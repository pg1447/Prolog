le(1,1). le(2,2). le(3,3). le(4,4). le(5,5). le(6,6).
le(3,1). le(4,1). le(4,2). le(5,2).le(6,5). le(6,2).

przechodni :- \+ (le(X,Y),le(Y,Z), \+ le(X,Z)).

antysymetryczny :- \+ (le(X,Y), le(Y,X) , X\=Y).

zwrotny :- \+ ((le(X, _); le(_, X)), \+ le(X, X)).

czesciowy_porzadek :- przechodni, antysymetryczny , zwrotny.




