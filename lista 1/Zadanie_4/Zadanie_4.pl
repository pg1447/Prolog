le(1,1). le(2,2). le(3,3). le(4,4). le(5,5). le(6,6).
le(3,1). le(4,1). le(4,2). le(5,2).le(6,5). le(6,2).








max(X):- le(Y,Y),X\=Y,le(X,Y).
maksymalna(X):- le(X,X), \+max(X).

min(X):- le(Y,Y),X\=Y,le(Y,X).
minimalna(X):- le(X,X), \+min(X).

najm(X):- le(Y,Y),X\=Y,\+le(X,Y).
najmniejsza(X):- le(X,X), \+najm(X).

najw(X):- le(Y,Y),X\=Y,\+le(Y,X).
najwieksza(X):- le(X,X), \+najw(X).
