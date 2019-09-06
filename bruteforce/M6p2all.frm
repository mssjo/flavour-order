#include defs.hf

load save/M6p2a.sav;
load save/M6p2b.sav;

local [M6p2a] = M6p2a;
local [M6p2b] = M6p2b;

.sort

multiply replace_(<ext1,a1>,...,<ext6,a6>);
multiply replace_(<p1ext,p1>,...,<p6ext,p6>);

.sort
drop;
local M6p2 = [M6p2a] + [M6p2b]/2;

#call strip(6)
.sort

#call mandel(6)

.sort

*#call adler(6,1)
#call prettymandel(6)

#call print()
.end

