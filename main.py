from kivy.app import App
from kivy.uix.button import Button
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.label import Label
from kivy.uix.screenmanager import ScreenManager, Screen, SwapTransition
from pyswip import Prolog

sm = ScreenManager(transition=SwapTransition())


class MenuScreen(Screen):

    def __init__(self, **kwargs):
        super(MenuScreen, self).__init__(**kwargs)
        floater = FloatLayout()
        mainButton = self.btt = Button(text="Press to resolve your career as programmer", size_hint=(0.5, 0.1),
                                pos_hint={'center_x': 0.5, 'center_y': .8})
        mainButton.bind(on_press=lambda x: self.goToQuestions())
        floater.add_widget(mainButton)
        self.add_widget(floater)

    def goToQuestions(self):
        prolog = Prolog()
        prolog.consult("data.pl")
        sm.current = "questions"


class QuestionsScreen(Screen):

    def __init__(self, **kwargs):
        super(QuestionsScreen, self).__init__(**kwargs)
        floater = FloatLayout()
        question = Label(text="Question number 1", size_hint=(0.8, 0.15),
                                pos_hint={'center_x': 0.5, 'center_y': .8})
        floater.add_widget(question)
        self.add_widget(floater)


class ChooseTechnologyApp(App):

    def build(self):
        sm.add_widget(MenuScreen(name="menu"))
        sm.add_widget(QuestionsScreen(name="questions"))
        return sm


if __name__ == '__main__':
    ChooseTechnologyApp().run()
