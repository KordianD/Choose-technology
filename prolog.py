from pyswip import Prolog


class PrologHelper:
    def __init__(self):
        self.prolog = Prolog()
        self.prolog.consult("main.pl")

    def get_question_from_prolog(self):
        for q in self.prolog.query("question(Q)"):
            return str(q["Q"])

    def get_answers_from_prolog(self, question):
        cmd = "answers({0}, A)".format(question)
        answers = []
        for a in self.prolog.query(cmd):
            answers.append(str(a["A"]))
        return answers

    def save_answer_to_prolog(self, question, answer):
        cmd = "remember(yes, {0}, {1})".format(question, answer)
        self.prolog.assertz(cmd)

    def get_possible_techs(self):
        techs = []
        for t in self.prolog.query("tech(X)"):
            techs.append(str(t["X"]))
        return techs
