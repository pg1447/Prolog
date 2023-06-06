ojciec(krzysztof,lukasz).
ojciec(krzysztof,magda).
ojciec(zenon,krzysztof).
matka(ewa,magda).
matka(ewa,lukasz).
mezczyzna(krzysztof).
mezczyzna(lukasz).
kobieta(ewa).
kobieta(magda).
rodzic(krzysztof,lukasz).
rodzic(ewa,lukasz).
rodzic(krzysztof,magda).
rodzic(ewa/home/lukasz/Pulpit/Prolog/lista_1/Zadanie_4/Zadanie_5.pl:2:,magda).



jest_matka(Mama) :- matka(Mama,Dziecko).
jest_ojcem(Tata) :- ojciec(Tata,Dziecko).
jest_synem(Syn) :- rodzic(Rodzic,Syn), mezczyzna(Syn).
siostra(Siostra,Osoba) :- rodzic(Rodzic,Siostra), rodzic(Rodzic,Osoba),
	kobieta(Siostra), Siostra \= Osoba.

dziadek(Dziadek,Wnuczek) :- rodzic(Rodzic,Wnuczek), ojciec(Dziadek,Rodzic).
rodzenstwo(X,Y) :- rodzic(Rodzic,X),rodzic(Rodzic,Y), X \= Y.
