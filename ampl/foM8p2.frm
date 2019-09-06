#include defs.hf
#include init_fo.hf

#call sfrule(8,2,[V8])

#call sfrule(6,2,[V6])

#call sfrule(4,2,[V4.1])
#call sfrule(4,2,[V4.2])
#call sfrule(4,2,[V4.3])

.sort
drop;

global [D8]     = diagram([V8], 1,...,8);
global [D5-3]   = diagram([V6], 1,...,5,
                    diagram([V4.3], 6,7,8, prop(p6+p7+p8))
                  ) * cycle(8, 1,...,8);
global [D3-2t-3] = diagram([V4.2], 
                    diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                  4,
                    diagram([V4.3], 5,6,7, prop(p5+p6+p7)),
                  8) * cycle(4, 1,...,8);
global [D3-2c-3] = diagram([V4.2],
                     diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                     diagram([V4.3], 4,5,6, prop(p4+p5+p6)),
                  7,8) * cycle(8, 1,...,8);

#call diagram(8)

#call mandel(8)

drop;
global [M8p2] = [D8] + [D5-3]
 + [D3-2t-3] + [D3-2c-3]
;

.sort

#call adler(8,1)
*#call uncycle(8,1)
#call prettymandel(8)

#call print()
.end
