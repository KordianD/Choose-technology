
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

% technologies - end results:

solve :-
	writeln("Hello "),
	top_goal(X),
	write("Your tech is "),
	write(X),
	write("\n").
solve :-
	writeln("Nothing found").

top_goal(X) :- 
	tech(X).

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

tech(swift) :-
	platform(mac).

platform(A) :-
	ask(plaform, A).

field(A) :-
	ask(field, A).

lang(A) :-
	ask(lang, A).

skill(A) :-
	ask(skill, A).

ask(Q, A) :-
	remember(yes, Q, A), % if "yes", true. otherwise, false.
	!.
ask(Q, A) :-
	remember(_, Q, A),
	!,
	fail.
ask(Q, A) :-
	write(Q:A), % question
	writeln('? '),
	read(X),
	assertz(remember(X, Q, A)), % remember answer
	X == yes.

	




