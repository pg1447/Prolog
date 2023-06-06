arc(a,b).
arc(b,a).
arc(b,c).
arc(c,d).

osiagalny(X,Y) :- jestosiagalny(X,Y,[]).
jestosiagalny(X,Y,L) :-(arc(X,Y),\+member(Y,L)); arc(X,A),\+ member(A,L),L1=[A|L],jestosiagalny(A,Y,L1).
