#prependpath ../lib/
#include defs.hf
#include init_fo.hf

#call sfrule(4,4,[V4])

#redefine SPLIT "split(2,2)"
#call sfrule(4,4,[V2/2])

global [D4]   = diagram([V4], 1,...,4);
global [D2/2] = diagram([V2/2], 1,...,4);

#call diagram(4)

drop;
global [M4p4] = [D4] + [D2/2];

#call mandel(4)
#call prettymandel(4)

#call print
.end
