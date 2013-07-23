special_chars = "\\=;()[]{},~$";
numbers = "0123456789";
alpha = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
alpha_num = alpha numbers cons;

# give m = 0 for at finde element i en liste
takeElemNo = \(x, xs) n m ~
    (\xs n m ~ (m 1 +) n xs takeElem) (\x ~ x) 0 n == $$ if;

# Vi skal lige have afgjort om == er en sammenligning


# tager imod argumenterne source, i (0), l (source length) og code = ""
## FUUUUUUCK
### Den her burde returnere en liste med alle tegn som er med i special chars.. Problemet er lidt at ting bliver næsten i starten af ens udtryk så en tre dyp if kommer til at være (((If3) If2) if1), hvilket gør koden meget meget ulæselig

tokens = \s i l c ~
     ((c l (i 1 + $$) s tokens $$$$) ((0 i s takeElemNo $$$) c cons $$) (0 i s takeElemNo $$$) special_chars in $$ if $$$) (\c ~ c) i l == $$ if;
