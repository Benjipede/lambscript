true = \x y ~ x;

false = \x y ~ y;

if = \a b c ~ c b a;

and = \p q ~ p q;

or = \p q ~ q p;

not = \p a b ~ a b p;

o = \f g x ~ x g $ f;

map = \_ b nil ~ b
      |f (x,xs) ~ x f $ xs f map;

foldl = \_ b nil ~ b
        |f b (x,xs) ~ xs x b f $$ f foldl;

foldr = \_ b nil ~ b
        |f b (x,xs) ~ x xs b f foldr $$$ f;

flip = \f x y ~ x y f;

head = (x,xs) ~ x;

tail = (x,xs) ~ xs;

length = \(x,nil) ~ 1
         |(x,xs) ~ xs length $ 1 +;

id = \x ~ x;

rev = \(x,nil) ~ (x,nil)
      |(x,xs) ~ xs rev $ x cons;

fst = \(x,y) ~ x;

snd = \(x,y) ~ y;

curry = \f x y ~ (x,y) f;

uncurry = \f p ~ p  snd $ p fst $ f;

cons = \nil ys ~ ys
       |(x,xs) ys ~ (x,(ys xs cons $$));

concat = \xss ~ xss [] cons foldr;

last = \(x,nil) ~ x
       |(x,xs) ~ xs last;

null = \nil ~ True
       |(_,_) ~ False;

zip = \(x,xs) (y,ys) ~ ((x,y),(ys xs zip $$))
      | _ _ ~ nil;

zipWith = \f (x,xs) (y,ys) ~ ((x y f $$),(ys xs f zipWith $$$))
          |_ _ _ ~ nil;

in = \_ nil ~ false;
     \a (x, xs) ~ (a xs in) true a x = if;
