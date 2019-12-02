from pyswip import Prolog


class PrologHelper:
    def __init__(self):
        self.prolog = Prolog()
        self.prolog.consult("main.pl")
        self.question_dict = {
            "likes": "What describes your interests the most?",
            "lang_status": "Do you prefer an older, established language, or a new, innovative one?",
            "platform": "What platform do you plan on using?",
            "skill": "Do you want a challenge or an easier approach?",
            "lang_performance": "What do you value more, performance or expressiveness?",
            "lang_execution": "Do you prefer working with compiled or interpreted languages?"
        }
        self.question_dict_reverse = {key: value for (value, key) in self.question_dict.items()}
        self.tech_dict = {
            "react": "React - A JavaScript front-end web framework.",
            "angular": "Angular - A TypeScript front-end web framework.",
            "vue": "Vue - A JavaScript front-end web framework.",
            "css_js": "CSS and Javascript - basics of web development.",
            "bootstrap": "Bootstrap - Basic web UI framework.",
            "jquery": "jQuery - fast, small, feature-rich JavaScript library.",
            "django": "Django - powerful Python back-end framework.",
            "flask": "Flask - simple Python back-end framework.",
            "node": "Node.js - JavaScript back-end framework.",
            "rocket": "Rocket - Rust back-end framework.",
            "javafx": "JavaFX - Web application platform",
            "electron": "Electron - JavaScript desktop development platform.",
            "wpf": "Windows Presentation Foundation - desktop development for Windows",
            "asp": "ASP.NET - back-end web framework for .NET",
            "razor": "Razor - front-end web framework for .NET",
            "netcore": ".NET Core - back-end web framework for .NET",
            "pytorch": "PyTorch - Python machine learning toolkit",
            "tensorflow": "Tensorflow - low-level machine learning toolkit",
            "caffee": "Caffee - Python machine learning toolkit",
            "keras": "Keras - Python machine learning toolkit",
            "dl4j": "DL4J - Java machine learning toolkit",
            "unity": "Unity - C# game development framework",
            "unreal": "Unreal - C++ game development framework",
            "swift_ui": "SwiftUI - UI framework for iOS and Mac",
            "godot": "Godot - C++ game development framework",
            "cocoa": "Cocoa - Apple's macOS API",
            "emscripten": "Emscripten - C to WebAssembly toolchain",
        }

    def get_question_from_prolog(self):
        for q in self.prolog.query("question(Q)"):
            return self.question_dict[str(q["Q"])]

    def get_answers_from_prolog(self, question):
        question = self.question_dict_reverse[question]
        cmd = "answers({0}, A)".format(question)
        answers = []
        for a in self.prolog.query(cmd):
            answers.append(str(a["A"]))
        return answers

    def save_answer_to_prolog(self, question, answer):
        print(question, answer)
        question = self.question_dict_reverse[question]
        cmd = "remember(yes, {0}, {1})".format(question, answer)
        self.prolog.assertz(cmd)

    def get_possible_techs(self):
        techs = []
        for t in self.prolog.query("tech(X)"):
            techs.append(str(t["X"]))
        return techs

    def get_tech_description(self, tech):
        return self.tech_dict[tech]

    def reset_prolog_memory(self):
        self.prolog.retractall("remember(_,_,_)")
