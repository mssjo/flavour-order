#prependpath ../lib/
#include defs.hf
#include init_fo.hf

#call sfrule(6,4,[V6.p4])

#call sfrule(4,4,[V4.p4])
#call sfrule(4,2,[V4])

#redefine SPLIT "split(2,2)"
#call sfrule(4,4,[V2/2])

#redefine SPLIT "split(2,4)"
#call sfrule(6,4,[V2/4])

global [D6]     = diagram([V6.p4], 1,...,6);
global [D2/4]   = diagram([V2/4], 1,...,6);
global [D3-3]   = diagram([V4.p4], 1,2,3, 
                    diagram([V4], 4,5,6, prop(-(p1+p2+p3)))
                  ) * cycle(6, 1,...,6);
global [D2/1-3] = diagram([V2/2], 1,2,3,
                    diagram([V4], 4,5,6, prop(-(p1+p2+p3)))
                  ) * cycle(4, 3,...,6);

#call diagram(6)

.sort

#call mandel(6)
#call prettymandel(6)

.sort
drop;

global [M2/4] = ([D2/4] + [D2/1-3])
#call group([Z2/4],0)
#include mandelbasis/basis6to24.hf

*global [M6] = ([D6] + [D3-3])
*#call group([ZN],6)


*global [M6p4] = [D6] + [D2/4] + [D3-3] + [D2/1-3];

.sort

#call uncycle

*#call dsl(6,2)
#call print

.end
