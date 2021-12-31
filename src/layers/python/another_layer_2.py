from my_oop_code.first_class import FirstClass
from my_oop_code.second_class import SecondClass


def init_first_class():
    first_instance = FirstClass()

    print("Test init_first_class from layer 2")

    return first_instance.func_one()


def init_second_class():
    second_instance = SecondClass()

    print("Test init_first_class from layer 2")

    return second_instance.func_one()


def init_second_class_func_two(param1, param2):
    second_instance = SecondClass()

    print("Test init_second_class_func_two from layer 2")

    return second_instance.func_two(param1, param2)
