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

list = \empty tail head p ~ (tail head (p 0 eq)) empty (p 2 eq);
nil = \p ~ true;
cons = \xs x p ~ x xs false list;
isempty = \xs ~ 2 xs;
tail = \xs ~ 1 xs;
head = \xs ~ 0 xs;

numbers = \x p ~ x p id (\x ~ ((1 x add) numbers)) false list $$$ print;

map = \f xs p ~ (xs tail $ f map) (xs head $ f) (xs isempty) list;
foldl = \f xs ~ (\i ~ (xs head $ i f) (tail xs) f foldl) id (xs isempty) if;

sum = \xs ~ 0 xs add foldl;

gcd = \a b ~ a (\a ~ (b a mod) b gcd) id (0 b eq);

mod5or3 = \x ~ ((5 x mod) 0 eq) ((3 x mod) 0 eq) or;

projecteuler1 = 999 (\f x ~ x
  ((\x ~ (1 x sub) f f) (id (x add) (x mod5or3)) o)
  id
  (x 0 eq)) (\x ~ x x);

