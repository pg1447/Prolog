left_of(olowek,klepsydra).
left_of(klepsydra,motyl).
left_of(motyl,ryba).
above(rower,olowek).
above(aparat,motyl).
above(klepsydra,wedka).
right_of(Object1,Object2) :- left_of(Object2,Object1).
below(Object1,Object2) :- above(Object2,Object1).

left(Object1,Object2) :- left_of(Object1,Object2);(left_of(Object1,Object3),left(Object3,Object2)).

right(Object1,Object2) :- right_of(Object1,Object2);(right_of(Object1,Object3),right(Object3,Object2)).


higher(Object1,Object2) :-  above(Object1,Object2);above(Object1,Object3) ,
	(right(Object3,Object2); left(Object3,Object2)).
