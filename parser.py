import tokens

class ParseError(Exception):
    pass

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
    @staticmethod
    def parse(token_stream, end_char=";"):
        stack = []
        token = token_stream.next()
        if token[0] == tokens.control and token[1] == "\\":
            args = []
            token = token_stream.next()
            while token[0] == tokens.variable:
                args.append(Variable(token[1]))
                token = token_stream.next()

            if token[0] != tokens.control and token[1] != "~":
                raise ParseError(
                        "functions should have the form: \\args ~ expression")
            body = Expression.parse(token_stream, end_char)
            return Function(args, body)
        while not (token[0] == tokens.control and token[1] == end_char):
            if token[0] == tokens.variable:
                stack.append(Variable(token[1]))
            if token[0] in (tokens.string, tokens.number):
                stack.append(Constant(token[1]))
            if token[0] == tokens.control and token[1] == "$":
                function = stack.pop()
                argument = stack.pop()
                stack.append(Evaluation(function, argument))
            if token[0] == tokens.control and token[1] == "(":
                expr = Expression.parse(token_stream, ")")
                stack.append(expr)
            token = token_stream.next()
        while len(stack) > 1:
            function = stack.pop()
            argument = stack.pop()
            stack.append(Evaluation(function,argument))
        return stack[0]

class Constant(Expression):
    def __init__(self, value):
        self.value = value
    def __str__(self, ident=0):
        return " "*ident + "Constant(%s)" % str(self.value)

class Variable(Expression):
    def __init__(self, name):
        self.name = name
    def __str__(self, ident=0):
        return " "*ident + "Variable(%s)" % self.name

class Function(Expression):
    def __init__(self, args, body):
        self.args = args
        self.body = body
    def __str__(self, ident=0):
        return " "*ident + "Function:\n" + \
            " "*ident + "  Arguments:\n" + \
            "\n".join(arg.__str__(ident+4) for arg in self.args) + "\n" + \
            " "*ident + "Body:\n" + \
            self.body.__str__(ident+4)
class Evaluation(Expression):
    def __init__(self, function, argument):
        self.function = function
        self.argument = argument
    def __str__(self, ident=0):
        return " "*ident + "Eval(%s, %s)" % (str(self.function), str(self.argument))
