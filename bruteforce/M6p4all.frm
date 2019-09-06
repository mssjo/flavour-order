
#include defs.hf

load save/M6p4a.sav;
load save/M6p4b.sav;

local [M6p4a] = M6p4a;
local [M6p4b] = M6p4b;

.sort

multiply replace_(<ext1,a1>,...,<ext6,a6>);
multiply replace_(<p1ext,p1>,...,<p6ext,p6>);

.sort
drop;
global M6p4 = [M6p4a] + [M6p4b];

#call strip(6)

#call mandel(6)

.sort

*#call adler(6,1)

#call prettymandel(6)

* Gets the last propblematic propagators
*multiply invprop(s56 - s34 - s23);
*id invprop(?a) * prop(?a) = 1;
*id invprop(i?) = i;

#call print
.end


