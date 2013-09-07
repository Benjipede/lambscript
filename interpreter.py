#!/usr/bin/python2
import token
import parser

class Type(object):
    def eval(self, arg):
        raise TypeError
    def clone(self):
        raise TypeError


class NativeFunction(Type):
    needed = None

    def __init__(self, env):
        self.arguments = []
        self.env = env

    def eval(self, arg):
        self.arguments.append(arg)
        if len(self.arguments) == self.needed:
            self.env = self.env.copy()
            return self.call()
        return self

    def call(self):
        pass

    def clone(self):
        cl = self.__class__(self.env)
        for arg in self.arguments:
            cl.eval(arg)
        return cl

    def __repr__(self):
        name = self.__class__.__name__
        return "<NativeFunction %s %d/%d>" % (name, self.needed, len(self.arguments))

class NativeTrue(NativeFunction):
    needed = 2
    def call(self):
        return self.arguments[0]

class NativeFalse(NativeFunction):
    needed = 2
    def call(self):
        return self.arguments[1]

class Integer(int, NativeFunction):
    needed = 1
    def __init__(self, n):
        int.__init__(self, n)
        NativeFunction.__init__(self, {})
    def call(self):
        if self.arguments[0].__class__ == Integer:
            if self.arguments[0] <= self:
                return NativeTrue({})
            else:
                return NativeFalse({})
        return NativeFalse({})
    def clone(self):
        return self
    def __repr__(self):
        return "<Integer(%s)>" % str(self)

class String(str, NativeFunction):
    needed = 1
    def call(self):
        if self.arguments[0].__class__ == String:
            if self.arguments[0] <= self:
                return NativeTrue({})
            else:
                return NativeFalse({})
        return NativeFalse({})
    def clone(self):
        return self
    def __repr__(self):
        return "<String(%s)>" % repr(str(self))

class Plus(NativeFunction):
    needed = 2
    def call(self):
        arg0 = self.arguments[0]
        if arg0.__class__ not in (Integer, String):
            raise TypeError
        arg1 = self.arguments[1]
        if arg0.__class__ != arg1.__class__:
            raise TypeError
        return arg0.__class__(arg0+arg1)

class Minus(NativeFunction):
    needed = 2
    def call(self):
        arg0 = self.arguments[0]
        if arg0.__class__ not in (Integer, String):
            raise TypeError
        arg1 = self.arguments[1]
        if arg0.__class__ != arg1.__class__:
            raise TypeError
        return arg0.__class__(arg0-arg1)

class Modulo(NativeFunction):
    needed = 2
    def call(self):
        arg0 = self.arguments[0]
        if arg0.__class__ != Integer:
            raise TypeError
        arg1 = self.arguments[1]
        if arg1.__class__ != Integer:
            raise TypeError
        return Integer(arg0 % arg1)

class LambdaFunction(NativeFunction):
    def __init__(self, env, func):
        NativeFunction.__init__(self, env)
        self.func = func
        self.needed = len(self.func.args)

    def call(self):
        env = self.env
        env.update({k.name:v for k,v in zip(self.func.args, self.arguments)})
        return interpret(self.func.body, self.env)
    def clone(self):
        cl = LambdaFunction(self.env, self.func)
        for arg in self.arguments:
            cl.eval(arg)
        return cl
    def __repr__(self):
        return "<LambdaFunction %d/%d>" % (self.needed, len(self.arguments))

def interpret(stmt, env):
    if stmt.__class__ == parser.Variable:
        return env[stmt.name]
    elif stmt.__class__ == parser.Constant:
        if type(stmt.value) == int:
            return Integer(stmt.value)
        elif type(stmt.value) == str:
            return String(stmt.value)
    elif stmt.__class__ == parser.Function:
        return LambdaFunction(env, stmt)

    elif stmt.__class__ == parser.Evaluation:
        arg = interpret(stmt.argument, env)
        func = interpret(stmt.function, env)
        func = func.clone()
        return func.eval(arg)

    elif stmt.__class__ == parser.Binding:
        env[stmt.name] = interpret(stmt.value, env)
        return None


def lamb_eval(source, env):
    toks = tokens.tokens(source)
    ret = None
    while True:
        try:
            stmt = parser.Statement.parse(toks)
            ret = interpret(stmt, env)
        except StopIteration:
            break
    return ret

if __name__ == "__main__":
    import sys
    import tokens
    sys.setrecursionlimit(20000)
    env = {}
    env["add"] = Plus(env)
    env["sub"] = Minus(env)
    env["mod"] = Modulo(env)
    if len(sys.argv) >= 2:
        source = open(sys.argv[1], "r").read()
        lamb_eval(source, env)
    while True:
        source = raw_input("> ")
        if source[:1] == "#":
            print env[source[1:]]
        else:
            ret = lamb_eval(source, env)
            print ret
