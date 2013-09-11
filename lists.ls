U = \x ~ x x;
true = \x y ~ x;
false = \x y ~ y;

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

[ = false;
, = true;
] = true nil (\s l p ~ l (\e ~ (e l cons) s U) p) U;
