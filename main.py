from kivy.app import App
from kivy.uix.button import Button
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.label import Label
from kivy.uix.screenmanager import ScreenManager, Screen, SwapTransition
from prolog import PrologHelper
from utils import split, get_offsets
from ui import WrappedButton

sm = ScreenManager(transition=SwapTransition())
prolog = PrologHelper()


class MenuScreen(Screen):

    def __init__(self, **kwargs):
        super(MenuScreen, self).__init__(**kwargs)
        floater = FloatLayout()
        mainButton = Button(text="Press to resolve your career as programmer", size_hint=(0.5, 0.2),
                            pos_hint={'center_x': 0.5, 'center_y': .8})
        mainButton.bind(on_press=lambda x: self.goToQuestions())
        floater.add_widget(mainButton)
        self.add_widget(floater)

    def goToQuestions(self):
        sm.current = "questions"


class QuestionsScreen(Screen):

    def __init__(self, **kwargs):
        super(QuestionsScreen, self).__init__(**kwargs)
        self.floater = FloatLayout()

        question_id = prolog.get_question_from_prolog()
        question_text = prolog.get_question_text(question_id)
        self.question = Label(text=question_text, size_hint=(0.8, 0.15),
                         pos_hint={'center_x': 0.5, 'center_y': .8})
        self.floater.add_widget(self.question)

        answers = prolog.get_answers_from_prolog(question_id)
        self.apply_answers_to_buttons(question_text, answers)

        self.add_widget(self.floater)

    def apply_answers_to_buttons(self, question, answers):
        answers_up, answers_down = split(answers)
        self.apply_buttons_to_floater(question, answers_up, 0.5)
        self.apply_buttons_to_floater(question, answers_down, 0.2)

    def apply_buttons_to_floater(self, question, answers, y_offset):
        answers_count = len(answers)
        button_size, space_between_buttons = get_offsets(answers_count)
        for idx, answer in enumerate(answers):
            button = WrappedButton(
                text=answer,
                size_hint=(button_size, 0.2),
                pos_hint={
                    'center_x': (space_between_buttons + button_size / 2) + idx * (space_between_buttons + button_size),
                    'center_y': y_offset},
                halign='center')
            button.bind(on_press=lambda q: self.answer_the_question(button.text, question))
            self.floater.add_widget(button)

    def answer_the_question(self, answer, question):
        prolog.save_answer_to_prolog(question, answer)
        tech = prolog.get_possible_techs()
        if len(tech) != 0:
            sm.current = "continue"
        answers = prolog.get_answers_from_prolog(question)
        self.question.text = prolog.get_question_from_prolog()
        self.reset_old_answers()
        self.apply_answers_to_buttons(self.question.text, answers)

    def reset_old_answers(self):
        buttons_count = -1
        while buttons_count != 0:
            for widget in self.floater.children:
                if type(widget) == WrappedButton:
                    self.floater.remove_widget(widget)
            buttons_count = len(self.floater.children) - 1


class ContinueScreen(Screen):

    def __init__(self, **kwargs):
        super(ContinueScreen, self).__init__(**kwargs)
        floater = FloatLayout()
        tech = prolog.get_possible_techs()
        label = Label(text=f"You should start to learn\n {' '.join(tech)}\n but maybe we can give you more propositions"
                           f"\n Do yo want continue?", size_hint=(0.8, 0.45),
                              pos_hint={'center_x': 0.5, 'center_y': .8})
        floater.add_widget(label)

        yes_button = Button(text="Yes!", size_hint=(0.2, 0.2),
                            pos_hint={'center_x': 0.2, 'center_y': .3})
        yes_button.bind(on_press=lambda x: self.goToQuestions())
        no_button = Button(text="No!", size_hint=(0.2, 0.2),
                            pos_hint={'center_x': 0.8, 'center_y': .3})
        no_button.bind(on_press=lambda x: self.close())

        floater.add_widget(yes_button)
        floater.add_widget(no_button)

        self.add_widget(floater)

    def goToQuestions(self):
        sm.current = "questions"

    def close(self):
        App.get_running_app().stop()


class ChooseTechnologyApp(App):

    def build(self):
        sm.add_widget(MenuScreen(name="menu"))
        sm.add_widget(QuestionsScreen(name="questions"))
        sm.add_widget(ContinueScreen(name="continue"))
        return sm


if __name__ == '__main__':
    ChooseTechnologyApp().run()
