true = \x y ~ x;
false = \x y ~ y;
if = \a b c ~ c b a;
o = \f g x ~ x g $ f;
id = \x ~ x;
and = \x y ~ x y x;
or = \x y ~ y x x;
not = \p x y ~ x y p;
leq = \x y ~ y x;
eq = \x y ~ x y $ y x $ and;

tuple = \x y p ~ x y p;

fst = \t ~ false t;
snd = \t ~ true t;

TF = \p ~ "F" "T" p;

nil = \p ~ true;
cons = \xs x ~ \p ~ (xs x (p 0 eq) if) false (p 2 eq) if;
isempty = \xs ~ 2 xs;
tail = \xs ~ 1 xs;
head = \xs ~ 0 xs;

numbers = \x ~ \p ~ (((1 x add) numbers) x (p 0 eq) if) false (p 2 eq) if;

map = \f xs p ~ ((xs tail $ f map) (xs head $ f) (p 0 eq) if) (2 xs) (p 2 eq) if;
foldl = \f xs ~ (\i ~ (xs head $ i f) (tail xs) f foldl) id (xs isempty) if;

sum = \xs ~ 0 xs add foldl;

gcd = \a b ~ a (\a ~ (b a mod) b gcd) id (0 b eq);

mod5or3 = \x ~ ((5 x mod) 0 eq) ((3 x mod) 0 eq) or;

foo = \x ~ x
  (\x ~ x
    (\x ~ (1 x sub) foo)
    (\x ~ ((1 x sub) foo) x add)
    (x mod5or3))
  id
  (x 0 eq);

projecteuler1 = 999 foo;
