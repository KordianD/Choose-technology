:- dynamic(remember/3).
:- dynamic(check/2).

consult(data).

% interface to ask questions
question(Q) :-
    list_of_questions(L),
    member(Q, L),
    \+remember(yes, Q, _),
    !.
% question(Q) :-
%     list_of_questions(L),
%     member(Q, L),
%     !.

% interface to list answers to a question
answers(Q, A) :-
    list_of_answers(Q, L),
    member(A, L).

% logic for detemining user preference and knowledge
 wants_similar(A) :-
     menuask(wants_similar, A, [yes, no, dnc]).
 wants_similar_to(A) :-
     knows(A).
 knows(A) :-
     list_of_langs(L),
     member(B, L),
     similar(A, B).

 % logic for using knowledge:
 check(Q, A) :-
     remember(yes, Q, A), % if "yes", true. otherwise, false.
     !.
 check(Q, A) :-
     remember(_, Q, A),
     !,
     fail.
