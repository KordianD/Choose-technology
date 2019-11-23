from pyswip import Prolog


prolog = Prolog()
prolog.consult("main.pl")

def get_question_from_prolog():
    for q in prolog.query("question(Q)"):
        return str(q["Q"])

def get_answers_from_prolog(question):
    a = []
    for q in prolog.query("answers(Q, A)"):
        a.append(str(q["A"]))
    return a

def save_answer_to_prolog(question, answer):
    cmd = "{0}({1})".format(question, answer)
    prolog.assertz("remember(yes,question,answer)")

def get_possible_techs():
    return list(prolog.query("tech(X)"))
