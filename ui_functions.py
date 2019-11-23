from utils import split, get_offsets
from ui import WrappedButton


def apply_answers_to_buttons(answers, floater):
    answers_up, answers_down = split(answers)
    apply_buttons_to_floater(answers_up, floater, 0.5)
    apply_buttons_to_floater(answers_down, floater, 0.2)


def apply_buttons_to_floater(answers, floater, y_offset):
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
        floater.add_widget(button)
