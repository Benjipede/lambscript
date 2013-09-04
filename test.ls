true = \x y ~ x;
false = \x y ~ y;
if = \a b c ~ c b a;
o = \f g x ~ x g $ f;
id = \x ~ x;

test0 = 1 plus;
test1 = 2 test0;
test2 = "fail!" "win!" true if;
test3 = "win!" "fail!" false if;
