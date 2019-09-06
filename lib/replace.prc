#procedure replace(NM)

id replace(?a) = rp(?a) * rf(?a);

id rp(<i1?>,...,<i{`NM'}?>) 
  = replace(<p1ext,ps[i1]>,...,<p{`NM'}ext,ps[i{`NM'}]>);
id rf(<i1?>,...,<i{`NM'}?>) 
  = replace(<ext1,as[i1]>,...,<ext{`NM'},as[i{`NM'}]>);

id replace(?a) = replace_(?a);

