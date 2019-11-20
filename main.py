from kivy.app import App
from kivy.uix.button import Button
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.label import Label
from kivy.uix.screenmanager import ScreenManager, Screen, SwapTransition
from prolog import start_prolog, get_answers_from_prolog, get_question_from_prolog
from ui_functions import apply_answers_to_buttons

sm = ScreenManager(transition=SwapTransition())


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
        prolog = start_prolog()
        sm.current = "questions"


class QuestionsScreen(Screen):

    def __init__(self, **kwargs):
        super(QuestionsScreen, self).__init__(**kwargs)
        floater = FloatLayout()
        question = Label(text=get_question_from_prolog(), size_hint=(0.8, 0.15),
                                pos_hint={'center_x': 0.5, 'center_y': .8})
        floater.add_widget(question)
        answers = get_answers_from_prolog()
        apply_answers_to_buttons(answers, floater)
        self.add_widget(floater)


class ChooseTechnologyApp(App):

    def build(self):
        sm.add_widget(MenuScreen(name="menu"))
        sm.add_widget(QuestionsScreen(name="questions"))
        return sm


if __name__ == '__main__':
    ChooseTechnologyApp().run()
