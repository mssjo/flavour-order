#prependpath ../lib/
#include defs.hf
#include init_fo.hf

#call sfrule(6,8,[V6.p8])

#call sfrule(4,2,[V4])
#call sfrule(4,4,[V4.p4])
#call sfrule(4,6,[V4.p6])
#call sfrule(4,8,[V4.p8])

#redefine SPLIT "split(2,2)"
#call sfrule(4,4,[V2/2])
#call sfrule(4,6,[V2/2.p6])
#call sfrule(4,8,[V2/2.p8])

#redefine SPLIT "split(2,4)"
#call sfrule(6,8,[V2/4.p8])

#redefine SPLIT "split(3,3)"
#call sfrule(6,8,[V3/3.p8])

#redefine SPLIT "split(2,2,2)"
#call sfrule(6,8,[V2/2/2.p8])

.sort
drop;

* Contact diagrams
global [D6]     = diagram([V6.p8], 1,...,6);
global [D3/3]   = diagram([V3/3.p8], 1,...,6);
global [D2/4]   = diagram([V2/4.p8], 1,...,6);
global [D2/2/2] = diagram([V2/2/2.p8], 1,...,6);

* O(p⁸) - O(p²) propagator diagrams
global [D3.p8-3]    
              = diagram([V4.p8], 1,2,3, 
                  diagram([V4], 4,5,6, prop(-(p1+p2+p3)))
              ) * cycle(6, 1,...,6);
global [D2/1.p8-3] 
              = diagram([V2/2.p8], 1,2,3,
                  diagram([V4], 4,5,6, prop(-(p1+p2+p3)))
              ) * cycle(4, 3,...,6);

* O(p⁶) - O(p⁴) propagator diagrams
global [D3.p6-3.p4] = diagram([V4.p6], 1,2,3,
                  diagram([V4.p4], 4,5,6, prop(-(p1+p2+p3)))
              ) * cycle(6, 1,...,6);
global [D2/1.p6-3.p4]
              = diagram([V2/2.p6], 1,2,3,
                  diagram([V4.p4], 4,5,6, prop(-(p1+p2+p3)))
              ) * cycle(4, 3,...,6);
global [D2/1-3.p6]
              = diagram([V2/2], 1,2,3,
                  diagram([V4.p6], 4,5,6, prop(-(p1+p2+p3)))
              ) * cycle(4, 3,...,6);
* There are three flavour-equivalent variants of this diagram: 
* propagator straddled by p1,p2, p3,p4, or p5,p6.
* For each, we also have to cycle the propagator and swap the two
* other traces separately.
global [D2/1.p6-1/2]
              = diagram([V2/2.p6], 3,4,2,
                  diagram([V2/2], 5,6,1, prop(-(p2+p3+p4)))
              ) * cycle(2, 1,2) 
                * (1 + permute(3,4, 5,6, 1,2) + permute(5,6, 1,2, 3,4))
                * (1 + permute(1,2, 5,6, 3,4));

* A singlet diagram
global [D3.p6|3] = diagram([V4.p6], 1,2,3,
                  diagram([V4.p4], 4,5,6, singlet(-(p1+p2+p3)))
                ) * cycle(3, 1,2,3) * cycle(3, 4,5,6)
                  * (1 + permute(4,5,6, 1,2,3));

#call diagram(6)
#call mandel(6)
drop;

global [M6p8] = [D6] + [D2/4] + [D3/3] + [D2/2/2]
              + [D3.p8-3] + [D2/1.p8-3]
              + [D3.p6-3.p4] + [D2/1.p6-3.p4] + [D2/1-3.p6] + [D2/1.p6-1/2]
              + [D3.p6|3];

#call print
.sort

#call adler(6,3);

#call print
.sort

#call mandelrand(6,0)

#call print
.end
