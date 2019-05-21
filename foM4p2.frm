#include defs.hf
#include init_fo.hf

#call sfrule(4,2,[V4])

.sort
drop;

global [D4]   = diagram([V4], 1,...,4);

#call diagram(4)

*#call dress(4)

#call mandel(4)
#call prettymandel(4)


#call print
.end
