true = \x y ~ x;
false = \x y ~ y;
if = \a b c ~ c b a;
o = \f g x ~ x g $ f;
id = \x ~ x;
and = \x y ~ x y x;
or = \x y ~ y x x;
not = \p x y ~ y x p;

#test0 = 1 add;
#test1 = 2 test0;
#test2 = "fail!" "win!" true if;
#test3 = "win!" "fail!" false if;

gcd = \a b ~ a (\a ~ (b a mod) b gcd) id (0 b eq) if;

mod5or3 = \x ~ ((5 x mod) 0 eq) ((3 x mod) 0 eq) or;
between = \x y n ~ (x n leq) (n y leq) and;

foo = \x y ~ x
  (\x ~ x
    (\x ~ y (1 x sub) foo)
    (\x ~ (y (1 x sub) foo) x add)
    (x mod5or3) if)
  id
  (y x leq) if;

projecteuler1 = 0 99 foo;
projecteuler1 = (100 199 foo) projecteuler1 add;
projecteuler1 = (200 299 foo) projecteuler1 add;
projecteuler1 = (300 399 foo) projecteuler1 add;
projecteuler1 = (400 499 foo) projecteuler1 add;
projecteuler1 = (500 599 foo) projecteuler1 add;
projecteuler1 = (600 699 foo) projecteuler1 add;
projecteuler1 = (700 799 foo) projecteuler1 add;
projecteuler1 = (800 899 foo) projecteuler1 add;
projecteuler1 = (900 999 foo) projecteuler1 add;
