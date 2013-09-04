control = object()
number = object()
string = object()
variable = object()

special_chars = "\\=;()[]{},~$"
numbers = "0123456789"
alpha = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
symbols = "+-.@?&!*^`"
def tokens_inner(source):
    i = 0
    while i<len(source):
        if source[i] in special_chars:
            yield (control, source[i])
        if source[i] == "\"":
            i += 1
            s = ""
            while source[i] != "\"":
                s += source[i]
                i += 1
            yield (string, s)
        if source[i] in numbers:
            s = ""
            while source[i] in numbers:
                s += source[i]
                i += 1
            yield (number, int(s))
        if source[i] in alpha:
            s = ""
            while source[i] in alpha+numbers:
                s += source[i]
                i += 1
            i -= 1
            yield (variable, s)
        if source[i] == "#":
            while source[i] != "\n":
                i += 1
        i += 1

class tokens:
    def __init__(self, source):
        self._tokens = tokens_inner(source)
        self.backs = []
    def __iter__(self):
        return self
    def next(self):
        if self.backs:
            return self.pop()
        return self._tokens.next()
    def push(self, tok):
        self.backs.append(tok)

