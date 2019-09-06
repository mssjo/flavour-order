#include defs.hf

load save/M6p6a.sav;
load save/M6p6b.sav;
load save/M6p6c.sav;

local [M6p6a] = M6p6a;
local [M6p6b] = M6p6b;
local [M6p6c] = M6p6c;

.sort
multiply replace_(<ext1,a1>,...,<ext6,a6>);
multiply replace_(<p1ext,p1>,...,<p6ext,p6>);

.sort

#call strip(6)

.sort

drop;
global M6p6 = [M6p6a] + [M6p6b] + [M6p6c]/2;


#call mandel(6)
*#call adler(6,1)
#call prettymandel(6)

#call print
.store
save save/M6p6.sav M6p6;

.end



