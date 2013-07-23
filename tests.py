import tokens
import parser

print "Test #1 'if'"
print str(parser.Expression.parse(tokens.tokens("\\a b c ~ c b a;")))
print ""

print "Test #2 'flip'"
print str(parser.Expression.parse(tokens.tokens("\\f x y ~ x y f;")))
print ""

print "Test #3 'o'"
print str(parser.Expression.parse(tokens.tokens("\\f g x ~ (x g) f ;")))
