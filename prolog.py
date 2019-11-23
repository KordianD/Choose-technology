from pyswip import Prolog


def start_prolog():
    prolog = Prolog()
    prolog.consult("data.pl")
    return prolog


def get_question_from_prolog():
    # mock
    return "Question number 1"


def get_answers_from_prolog():
    # mock
    return ['Answer 111111111111111111111', 'Answer 2', 'Answer 3', 'Answer 4', 'Answer 5', 'Answer 6', 'Answer 7']

def save_answer_to_prolog(question, answer):
    cmd = "{0}({1})".format(question, answer)
    prolog.assertz("remember(yes,question,answer)")

def get_possible_techs():
    return list(prolog.query("tech(X)"))
