class SecondClass:
    def func_one(self):
        print("This is response from SecondClass, func one")

        return "Ok"

    def func_two(self, param1, param2):
        print("This is func with params invoked from layer.")

        return [param1, param2]
