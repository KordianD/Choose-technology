:- dynamic(remember/3).
:- dynamic(check/2).

consult(data).

% interface to ask questions
question(Q) :-
    list_of_questions(L),
    member(Q, L),
    remember(_, Q, answers(Q)),
    fail.
question(Q) :-
    list_of_questions(L),
    member(Q, L),
    !.

% interface to
answers(Q, A) :-
    list_of_answers(Q, L),
    member(A, L).

% logic for detemining user preference and knowledge
 wants_similar(A) :-
     menuask(wants_similar, A, [yes, no, dnc]).
 wants_similar_to(A) :-
     knows(A).
     % ask(wants_similar_to, A).
 knows(A) :-
     list_of_langs(L),
     member(B, L),
     similar(A, B).

 % logic for using knowledge:
 exclusive(A) :-
     A == wants_similar.
 check(Q, A) :-
     remember(yes, Q, A), % if "yes", true. otherwise, false.
     !.
 check(Q, A) :-
     remember(_, Q, A),
     !,
     fail.

% other stuff

% encode similarities between languages and ask user what he prefers
% definition of similarity
% similar(A, B) :-
%     similar_to(A, B).
% similar(A, B) :-
%     similar_to(B, A).
% similar(A, B) :-
%     A == B.
% list of languages and relations
