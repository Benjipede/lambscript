control = object()
number = object()
string = object()
variable = object()

special_chars = "\\=;()[]{},~$"
numbers = "0123456789"
alpha = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
def tokens(source):
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
            yield (variable, s)
        if source[i] == "#":
            while source[i] != "\n":
                i += 1
        i += 1
