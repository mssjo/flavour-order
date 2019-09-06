#include defs.hf
#include init_fo.hf

#call sfrule(6,2,[V6])
#call sfrule(4,2,[V4.1])
#call sfrule(4,2,[V4.2])

global [D6]   = diagram([V6], 1,...,6);
global [D3-3] = diagram([V4.1], 1,2,3, 
                  diagram([V4.2], 4,5,6, prop(-(p1+p2+p3)))
                ) * cycle(3, 1,...,6); 

#call diagram(6)

drop;
global [M6p2] = [D6] + [D3-3];

.sort


*#call mandel(6)
*#call prettymandel(6)

#call print
.sort

*#call uncycle(6,0)
*#call prettymandel(6)

*#call adler(6,1)


#call mandel(6)
#call prettymandel(6)

.sort
drop;

global ampl = [M6p2] 
*#call group([ZN],6)
;
*#call uncycle

*#call dsl(6,0)
#call adler(6,1)

#call print

.end
