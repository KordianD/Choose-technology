from pyswip import Prolog


class PrologHelper:
    def __init__(self):
        self.prolog = Prolog()
        self.prolog.consult("main.pl")
        self.question_dict = {
            "likes": "What describes your interests the most?",
            "lang_status": "Do you prefer an older, established language, or a new, innovative one?",
            "platform": "What platform do you plan on using?",
            "skill": "How would you describe your programming skills?",
            "lang_performance" : "What do you value more, performance or expresiveness?",
            "lang_execution" : "Do you prefer working with compiled or interpreted languages?"
        }
        self.question_dict_reverse = {key: value for (value, key) in self.question_dict.items()}
        self.tech_dict = {
            ""
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
        question = self.question_dict_reverse[question]
        cmd = "remember(yes, {0}, {1})".format(question, answer)
        self.prolog.assertz(cmd)

    def get_possible_techs(self):
        techs = []
        for t in self.prolog.query("tech(X)"):
            techs.append(str(t["X"]))
        return techs
