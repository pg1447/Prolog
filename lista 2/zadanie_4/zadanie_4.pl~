ma(lukasz,ksiazke).
ma(ola,komputer).
ma(magda,rower).
ma(krzysztof,telewizor).
ma(ewa,parasol).
daje(1,lukasz,ksiazke,ewa).
daje(2,ewa,ksiazke,krzysztof).
daje(2,ola,komputer,magda).
daje(3,magda,rower,ola).
daje(3,krzysztof,telewizor,lukasz).
daje(6,ewa,parasol,krzysztof).



ma(A,B,C) :- nieoddal(A,B,C); dostal(A,B,C).
nieoddal(A,B,C) :- ma(B,C) , \+ ( daje(X,B,C,_),X=<A).
dostal(A,B,C) :- daje(X,_,C,B),X =< A,\+ (daje(X1,B,C,_),A>=X1,X1>X).
