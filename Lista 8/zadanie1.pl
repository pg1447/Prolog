:- use_module(library(sgml)).
:- use_module(library(xpath)).
:- use_module(library(url)).

serwery(FILE, SET) :-
  load_html(FILE, DOM, []),
  findall(HOST, (xpath(DOM, //a(@href), HREF), parse_url(HREF,"localhost",X), X = [_,host(HOST),_]) ,LIST),
  list_to_set(LIST,SET).
