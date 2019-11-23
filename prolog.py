from pyswip import Prolog

prolog = Prolog()
prolog.consult("main.pl")


def get_question_from_prolog():
    for q in prolog.query("question(Q)"):
        return str(q["Q"])


def get_answers_from_prolog(question):
    answers = []
    for a in prolog.query("answers(Q, A)"):
        answers.append(str(a["A"]))
    return answers


def save_answer_to_prolog(question, answer):
    cmd = "remember(yes, {0}, {1})".format(question, answer)
    prolog.assertz(cmd)


def get_possible_techs():
    techs = []
    for t in prolog.query("tech(X)"):
        techs.append(str(t["X"]))
    return techs
