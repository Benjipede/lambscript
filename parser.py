import tokens

class Binding(object):
    def __init__(name, value):
        self.name = name
        self.value = value

    @staticmethod
    def parse(token_stream):
        name = token_stream.next()
        equalsign = token_stream.next()
        value = Expression.parse(token_stream)
        return Binding(name, value)


class Expression(object):
    def __init__(self, value):
        self.value
    @staticmethod
    def parse(token_stream):
        stack = []
        token = token_stream.next()
        while token[0] != tokens.control and token[1] != ";":
            if token[0] == tokens.variable:
                stack.append(Variable(token[1]))
            if token[0] in (tokens.string, tokens.number):
                stack.append(Constant(token[1]))
            if token[0] == tokens.control and token[1] == "$":
                function = stack.pop()
                argument = stack.pop()
                stack.append(Evaluation(function, argument))
            token = token_stream.next()
        while len(stack) > 1:
            function = stack.pop()
            argument = stack.pop()
            stack.append(Evaluation(function,argument))
        return stack[0]

class Constant(Expression):
    def __init__(self, value):
        self.value = value

class Variable(Expression):
    def __init__(self, name):
        self.name = name

class Evaluation(Expression):
    def __init__(self, function, argument):
        self.function = function
        self.argument = argument


