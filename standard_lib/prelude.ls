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

length = \(x,[]) ~ 1
         |(x,xs) ~ xs length $ 1 +;

id = \x ~ x;

rev = \(x,[]) ~ (x,[])
      |(x,xs) ~ xs rev $ x cons;

fst = \(x,y) ~ x;

snd = \(x,y) ~ y;

curry = \f x y ~ (x,y) f;

uncurry = \f p ~ snd p $ fst p $ f;

cons = \[] ys ~ ys
       |(x,xs) ys ~ (x,(ys xs cons $$));

concat = \xss ~ xss [] cons foldr;

last = \(x,[]) ~ x
       |(x,xs) ~ xs last;

null = \[] ~ True
       |(_,_) ~ False;

zip = \(x,xs) (y,ys) ~ ((x,y),(ys xs zip $$))
      | _ _ ~ [];

zipWith = \f (x,xs) (y,ys) ~ ((x y f $$),(ys xs f zipWith $$$))
          |_ _ _ ~ [];
