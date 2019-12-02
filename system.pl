:- dynamic(remember/3).
:- dynamic(check/2).

consult(data).

% utils
isEmpty([]).
oneElem([H]).
choose([],_) :- !, fail.
choose(L, E) :-
    length(L, Length),
    random(0, Length, I),
    nth0(I, L, E).

% interface to ask questions
question(Q) :-
    list_of_questions(L),
    member(Q, L),
    \+remember(yes, Q, _),
    !.
question(Q) :-
    list_of_questions([H|L]),
    member(Q, L),
    \+remember(yes, Q, any),
    answered(Q),
    !.
question(Q) :-
    list_of_questions([H|L]),
    member(Q, L),
    \+remember(yes, Q, any),
    answers(Q, A),
    \+remember(yes, Q, A),
    !.

% interface to list answers to a question
answers(Q, A) :-
    list_of_answers(Q, L),
    member(A, L),
    \+remember(yes, Q, A).

answered(Q) :-
    findall(A, remember(yes, Q, A), L),
    oneElem(L),
    !.

 % logic for using knowledge:
 check(Q, A) :-
     remember(yes, Q, A), % if "yes", true. otherwise, false.
     !.
 check(Q, A) :-
     remember(yes, Q, any),
     !.
 check(Q, A) :-
     remember(_, Q, A),
     !,
     fail.
