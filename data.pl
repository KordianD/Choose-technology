
% Questions:
% 1. What is your main motivation and why do you want to code?
% 1. options a) Design mobile apps b) Build websites c) Design video games d) Get a job e) Learn a new skill f) Have a shouting matches with g) Analysis large datasets h) Processing natural language i) Processing images and finding shape patterns
% 2. Path a: Apple or Android
% 2. Path b: Sexiness or stability
% 2. Path c: Which engine do you prefer use?
% 2. Path d: Startup or established
% 2. Path e: How invested are you?
% 2. Path f: compiler, using regular expressions, my hardware
% 2. Path g:
% 2. Path h:
% 2. Path i:


:- dynamic(remember/3).

solve :-
    retractall(remember(_,_,_)),
    writeln("Hello "),
    top_goal(X),
    write("Your tech is "),
    writeln(X).
solve :-
    secondary_goal(X),
    writeln("No technology found, but consider learning: "),
    writeln(X).

top_goal(X) :-
    tech(X).

secondary_goal(X) :-
    lang(X).

% technologies - end results:

tech(react) :-
    field(web_frontend),
    lang(javascript),
    skill(intermediate).

tech(angular) :-
    field(web_frontend),
    lang(typescript),
    skill(intermediate).

tech(vue) :-
    field(web_frontend),
    lang(javascript),
    skill(intermediate).

tech(css_js) :-
    field(web_frontend),
    lang(javascript),
    skill(basic).

tech(django) :-
    field(web_backend),
    lang(python),
    skill(intermediate).

tech(flask) :-
    field(web_backend),
    lang(python),
    skill(basic).

tech(electron) :-
    field(desktop),
    lang(javascript),
    platform(any).

tech(wpf) :-
    field(desktop),
    lang(csharp),
    platform(windows).

tech(asp) :-
    field(web_backend),
    lang(csharp).

tech(razor) :-
    field(web_frontend),
    lang(csharp).

tech(netcore) :-
    field(web_backend),
    lang(csharp).

tech(pytorch) :-
    field(machine_learning),
    lang(python).

tech(tensorflow) :-
    field(machine_learning),
    lang(python).

tech(dl4j) :-
    field(machine_learning),
    lang(java).

tech(unity) :-
    field(gamedev),
    lang(csharp).

tech(unreal) :-
    field(gamedev),
    lang(cpp).

tech(swift_ui) :-
    platform(ios),
    lang(swift).

tech(swift_ui) :-
    platform(mac),
    lang(swift).

tech(cocoa) :-
    platform(mac),
    lang(objective_c).


% 2nd level attributes:

platform(A) :-
    ask(plaform, A).

field(A) :-
    fail. % temporary - for testing

% determine language

% encode similarities
similar(A, B) :-
    similar_to(A, B).
similar(A, B) :-
    similar_to(B, A).
similar(A, B) :-
    A == B.
list_of_langs([swift, objective_c, c]).
similar_to(c, objective_c).

wants_similar(A) :-
    ask(wants_similar, A).

knows(A) :-
    list_of_langs(L),
    member(A, L),
    ask(knows, A).

% check if user wants a language similar to one they know
lang(A) :-
    wants_similar(yes),
    knows(B),
    similar(B,A).

lang(A) :-
    wants_similar(no),
    knows(B),
    not(similar(B,A)).

lang(A) :-
    wants_similar(dnc),
    list_of_langs(L),
    member(A, L).

skill(A) :-
    ask(skill, A).

% asking questions and remembering answers logic:
exclusive(A) :-
    A == wants_similar.

ask(Q, A) :-
    remember(yes, Q, A), % if "yes", true. otherwise, false.
    !.
ask(Q, A) :-
    remember(_, Q, A),
    !,
    fail.
ask(Q, A) :-
    exclusive(Q),
    remember(yes,Q,A2),
    A \== A2,
    !,
    fail.
ask(Q, A) :-
    write("question: "), writeln(Q),
    write("answer: "), writeln(A), % question
    writeln("yes or no? "),
    read(X),
    assertz(remember(X, Q, A)), % remember answer
    X == yes.

%menuask(Q, A, L) :-
%    fail.
