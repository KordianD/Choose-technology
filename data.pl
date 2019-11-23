
% Questions:
% 1. What is your main motivation and why do you want to code?
% 1. options a) Design mobile apps b) Build websites c) Design video games d) Get a job e) Learn a new skill f) Have a shouting matches with g) Analysis large datasets h) Processing natural language i) Processing images and finding shape patterns
% 2. Path a: Apple or Android
% 2. Path b: Sexiness or stability
% 2. Path c: Which engine do you prefer use?
% 2. Path d: Startup or established
% 2. Path e: How invested are you?
% 2. Path f: compiler, using regular expressions, my hardware

% list of questions to possibly ask user:
list_of_questions([likes, lang, platform]).

% lists of possible answers:
list_of_answers(likes, [ux, complex_systems, web_frontend, design, innovation, science, games]).

list_of_asnwers(lang, [c, cpp, objective_c, swift]).
similar_to(c, objective_c).
similar_to(c, cpp).

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

likes(X) :-
    check(likes, X).
lang(X) :-
    check(lang, X).
platform(X) :-
    check(platform, X).
skill(X) :-
    check(skill, X).
