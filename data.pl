
% Questions:
% 1. What is your main motivation and why do you want to code?
% 1. options a) Design mobile apps b) Build websites c) Design video games d) Get a job e) Learn a new skill f) Have a shouting matches with g) Analysis large datasets h) Processing natural language i) Processing images and finding shape patterns
% 2. Path a: Apple or Android
% 2. Path b: Sexiness or stability
% 2. Path c: Which engine do you prefer use?
% 2. Path d: Startup or established
% 2. Path e: How invested are you?
% 2. Path f: compiler, using regular expressions, my hardware

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
solve :-
    writeln("Nothing found").

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
    lang(csharp),
    platform(any).

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
field(gamedev) :-
    likes(games).
field(gamedev) :-
    likes(design).
field(machine_learning) :-
    likes(science).
field(machine_learning) :-
    likes(innovation).
field(web_frontend) :-
    likes(design).
field(web_frontend) :-
    likes(ux).
field(web_backend) :-
    likes(complex_systems).
field(desktop) :-
    likes(ux).

platform(A) :-
    ask(plaform, A).

% determine language

% encode similarities between languages and ask user what he prefers
% definition of similarity
similar(A, B) :-
    similar_to(A, B).
similar(A, B) :-
    similar_to(B, A).
similar(A, B) :-
    A == B.
% list of languages and relations
list_of_langs([c, cpp, objective_c, swift]).
similar_to(c, objective_c).
similar_to(c, cpp).

% logic for detemining user preference and knowledge
wants_similar(A) :-
    menuask(wants_similar, A, [yes, no, dnc]).
wants_similar_to(A) :-
    knows(A),
    ask(wants_similar_to, A).
knows(A) :-
    list_of_langs(L),
    member(B, L),
    similar(A, B),
    ask(knows, A).

% check if user wants a language similar to one they know
lang(A) :-
    wants_similar(yes),
    wants_similar_to(B),
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
    write("question: "),
    writeln(Q),
    write("answer: "),
    writeln(A), % question
    writeln("yes or no? "),
    read(X),
    assertz(remember(X, Q, A)), % remember answer
    X == yes.

% menu with multiple answers
menuask(Q, A, _) :-
    remember(yes, Q, A), % if "yes", true. otherwise, false.
    !.
menuask(Q, A, _) :-
    remember(_, Q, A),
    !,
    fail.
menuask(Q, A, _) :-
    exclusive(Q),
    remember(yes, Q, A2),
    A \== A2,
    !,
    fail.
menuask(Q, A, L) :-
    write(Q),
    writeln(":"),
    writeln(L),
    read(X),
    legal(Q, A, L, X),
    assertz(remember(yes, Q, X)), % remember answer
    X == A.
legal(_, _, L, X) :-
    member(X, L),
    !.
legal(Q, A, L, X) :-
    write("Illegal value: "),
    writeln(X),
    menuask(Q, A, L).
