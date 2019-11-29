
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
list_of_questions([likes, lang_status, platform, skill]).

% lists of possible answers:
list_of_answers(likes, [user_experience, complex_systems, web_apps, design, innovation, science, games]).
list_of_answers(lang, [c, cpp, objective_c, swift, javascript, typescript, python, java, csharp, rust]).
list_of_answers(platform, [any, windows, ios, mac]).
list_of_answers(skill, [basic, intermediate]).
list_of_answers(lang_status, [new, established, any]).
list_of_answers(lang_traits, [procedural, object_oriented, functional, async, compiler, regex]).
list_of_answers(lang_performance, [performance, expressiveness, any]).

similar_to(c, objective_c).
similar_to(c, cpp).
similar_to(java, csharp).

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
tech(bootstrap) :-
    field(web_frontend),
    lang(javascript),
    skill(basic).
tech(jquery) :-
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
tech(node) :-
    field(web_backend),
    lang(javascript).
tech(rocket) :-
    lang(rust),
    field(web_backend).
tech(javafx) :-
    field(web_backend),
    lang(java).
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
tech(tensorflow) :-
    field(machine_learning),
    lang(cpp).
tech(caffee) :-
    field(machine_learning),
    lang(cpp).
tech(keras) :-
    field(machine_learning),
    lang(python),
    skill(basic).
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
tech(godot) :-
    field(gamedev),
    lang(cpp),
    skill(intermediate).
tech(cocoa) :-
    platform(mac),
    lang(objective_c).

% 2nd level attributes:
field(X) :-
    likes(any).
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
    likes(user_experience).
field(web_backend) :-
    likes(complex_systems).
field(web_frontend) :-
    likes(web_apps).
field(web_backend) :-
    likes(web_apps).
field(desktop) :-
    likes(user_experience).
field(desktop) :-
    likes(complex_systems).

lang(X) :-
    lang_status(any).
lang(c) :-
    lang_status(established).
lang(cpp) :-
    lang_status(established).
lang(python) :-
    lang_status(established).
lang(rust) :-
    lang_status(new).
lang(typescript) :-
    lang_status(new).
lang(javascript) :-
    lang_status(established).
lang(java) :-
    lang_status(established).
lang(csharp) :-
    lang_status(established).

likes(X) :-
    check(likes, X).
lang(X) :-
    check(lang, X).
platform(X) :-
    check(platform, X).
skill(X) :-
    check(skill, X).
lang_status(X) :-
    check(lang_status, X).
