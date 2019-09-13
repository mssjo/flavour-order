#prependpath ../lib/
#include defs.hf
#include init_fo.hf

#call sfrule(4,8,[V4])

#redefine SPLIT "split(2,2)"
#call sfrule(4,8,[V2/2])

.sort
drop;

global [D4]   = diagram([V4], 1,...,4);
global [D2/2] = diagram([V2/2], 1,...,4);

#call diagram(4)

#call mandel(4)
drop;
global [M4p8] = [D4] + [D2/2];

#call prettymandel(4)

#call print
.end
