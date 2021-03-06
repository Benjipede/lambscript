o = \f g x ~ x g $ f;
id = \x ~ x;
flip = \f x y ~ x y f;
U = \f ~ f f;
I = id;

true = \x y ~ x;
false = \x y ~ y;
if = \a b c ~ c b a;
and = \x y ~ x y x;
or = \x y ~ y x x;
not = \p x y ~ x y p;
leq = \x y ~ y x;
eq = \x y ~ x y $ y x $ and;

+ = add;
- = sub;
% = mod;
++ = 1 +;
-- = 1 - flip;

tuple = \x y p ~ x y p;

fst = \t ~ false t;
snd = \t ~ true t;

TF = \p ~ "F" "T" p;

list = \empty tail head p ~ empty tail head p;
nil = \p ~ true;
cons = \xs x ~ x xs false list;
null = \xs ~ (\a b c ~ c) xs;
tail = \xs ~ (\a b c ~ b) xs;
head = \xs ~ (\a b c ~ a) xs;

foldr = \f b xs ~ b (\b ~ (xs head) (xs tail $ b f foldr) f) id xs null;

filter = \f xs p ~ xs
    (\xs ~ p
        (xs tail $ f filter)
        ((xs head) (xs tail $ f filter) cons)
      (xs head) f)
    id
  xs null;

numbers = \x p ~ x p id (\x ~ x inc $ numbers) (\x ~ false) list;

map = \f xs ~ xs (head f o) (tail f map $ o) null list $$$ flip;

# below here should not be in prelude

gcd = \a b ~ a (\a ~ (b a %) b gcd) I (0 b eq);

mod5or3 = \x ~ ((5 x %) 0 eq) ((3 x %) 0 eq) or;

pe1 = 999 (\f x ~ x ((-- f U $ o) (I x + $ x mod5or3) o) I x 0 eq) U;

