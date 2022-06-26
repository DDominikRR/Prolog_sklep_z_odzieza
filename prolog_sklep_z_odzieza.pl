ubranie(koszula, gora, dlugie, cienkie).
ubranie(bluza, gora, dlugie, grube).
ubranie(t-shirt, gora, krotkie, cienkie).
ubranie(kurtka-bezrekawnik, gora, krotkie, grube).
ubranie(spodnica, dol, dlugie, cienkie).
ubranie(spodnie, dol, dlugie, cienkie).
ubranie(shorty, dol, krotkie, cienie).

ubranieCena(koszula, 70).
ubranieCena(bluza, 150).
ubranieCena(t-shirt, 35).
ubranieCena(spodnica, 50).
ubranieCena(spodnie, 120).
ubranieCena(shorty, 45).
ubranieCena(kurtka-bezrekawnik, 220).

ubranieIlosc(koszula, xl, 44).
ubranieIlosc(koszula, l, 13).
ubranieIlosc(koszula, m, 5).
ubranieIlosc(koszula, s, 11).
ubranieIlosc(bluza, xl, 23).
ubranieIlosc(bluza, l , 13).
ubranieIlosc(bluza, m, 5).
ubranieIlosc(bluza, s, 0).
ubranieIlosc(bluza, xs, 1).

/* kto, co, ile*/
kupil(ania,[bluza,koszula]).
kupil(bartek,[bluza,koszula,shorty,bluza]).
kupil(zosia,[]).
kupil(kasia,[kurtka-bezrekawnik,t-shirt,koszula,shorty]).

czyNaMagazynie(X,Y) :- ubranieIlosc(X,Y,I), I > 0. 
/*kategoria gora,dol| dlugosc... */
ubraniawKategorii(L, K, D, G) :- findall(Nazwa, ubranie(Nazwa, K, D, G), L).
ubraniaWcenie(L, C) :- findall(X, (ubranieCena(X, Cena), Cena =< C), L). 
iloscNaMagazynie(N, R) :- findall(Ile, ubranieIlosc(N, _, Ile), L), sumlist(L,R).
cenaZestawuDwoch(X,Y,R) :- ubranieCena(X,A), ubranieCena(Y,B), R is A+B.
cojestTansze(X,Y) :- ubranieCena(X,A),ubranieCena(Y,B),A >= B, write(Y),write(' jest tansze od '),write(X).                                      
cojestTansze(X,Y) :- ubranieCena(X,A),ubranieCena(Y,B),A < B, write(Y), write(' jest drozsze od '),write(X).


/* rabat dla osob ktore kupily wiecej niz 3 rzeczy*/
czyjestrabat(X) :- ileKtoskupil(X,Z), Z > 3.
iloscProduktow([],0).
iloscProduktow([_|O], A) :-iloscProduktow(O, A1), A is A1+1.
ileKtoskupil(X,Y) :- kupil(X,L), iloscProduktow(L,Y).
member(X,[X|_]).
member(X,[_|Xs]) :- member(X,Xs).
czyKupil(X,Y) :- kupil(X,L),member(Y,L).

czyKomplet(L,O) :- (ubranie(L,G,_,_),ubranie(O,D,_,_),G = 'gora', D = 'dol')
    ;(ubranie(O,G,_,_),ubranie(L,D,_,_),G = 'gora', D = 'dol').

countProduktyunique(_, [], 0).
countProduktyunique(X, [X | T], N) :-!, countProduktyunique(X, T, N1), N is N1 + 1.
countProduktyunique(X, [_ | T], N) :-countProduktyunique(X, T, N).
ileKupil(X,Y,Z):-kupil(X,L),countProduktyunique(Y,L,Z).
/* kto, co, ile */

/* przykladowe zapytania:
czyNaMagazynie(koszula,xl).
ubraniawKategorii(X,gora,_,_).
ubraniaWcenie(X,50).
iloscNaMagazynie(koszula,R).
czyNaMagazynie(bluza,Y).
ubraniawKategorii(L,gora,_,_).
cenaZestawuDwoch(bluza,koszula,C).
cojestTansze(bluza,_).
czyjestrabat(ania).
czyjestrabat(zosia).
ileKtoskupil(bartek,Y).
ileKtoskupil(zosia,Y).
czyKupil(ania,shorty).
czyKupil(ania,bluza).
czyKomplet(bluza,koszula).
czyKomplet(bluza,spodnie).
ileKupil(ania,bluza,Y).
ileKupil(bartek,bluza,Y).
ileKupil(zosia,bluza,Y).
ubraniawKategorii(L,gora,dlugie,cienkie).
*/
