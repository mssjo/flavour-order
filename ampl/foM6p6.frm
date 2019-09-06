#include defs.hf
#include init_fo.hf

#call sfrule(6,6,[V6.p6])

#call sfrule(4,2,[V4])
#call sfrule(4,4,[V4.p4.1])
#call sfrule(4,4,[V4.p4.2])
#call sfrule(4,6,[V4.p6])

#redefine SPLIT "split(2,2)"
#call sfrule(4,4,[V2/2.1])
#call sfrule(4,4,[V2/2.2])
#call sfrule(4,6,[V2/2.p6])

#redefine SPLIT "split(2,4)"
#call sfrule(6,6,[V2/4.p6])

#redefine SPLIT "split(3,3)"
#call sfrule(6,6,[V3/3.p6])

#redefine SPLIT "split(2,2,2)"
#call sfrule(6,6,[V2/2/2])

*#call print
*.end

.sort

#if(`RERUNDIAG')

drop;

* Contact diagrams
global [D6]     = diagram([V6.p6], 1,...,6);
global [D3/3]   = diagram([V3/3.p6], 1,...,6);
global [D2/4]   = diagram([V2/4.p6], 1,...,6);
global [D2/2/2] = diagram([V2/2/2], 1,...,6);

* O(p⁶) - O(p²) propagator diagrams
global [D3.p6-3]    
              = diagram([V4.p6], 1,2,3, 
                  diagram([V4], 4,5,6, prop(-(p1+p2+p3)))
              ) * cycle(6, 1,...,6);
global [D2/1.p6-3] 
              = diagram([V2/2.p6], 1,2,3,
                  diagram([V4], 4,5,6, prop(-(p1+p2+p3)))
              ) * cycle(4, 3,...,6);

* O(p⁴) - O(p⁴) propagator diagrams
global [D3-3] = diagram([V4.p4.1], 1,2,3,
                  diagram([V4.p4.2], 4,5,6, prop(-(p1+p2+p3)))
              ) * cycle(3, 1,...,6);
global [D2/1-3]
              = diagram([V2/2.1], 1,2,3,
                  diagram([V4.p4.2], 4,5,6, prop(-(p1+p2+p3)))
              ) * cycle(4, 3,...,6);
* There are three flavour-equivalent variants of this diagram: 
* propagator straddled by p1,p2, p3,p4, or p5,p6.
global [D2/1-1/2]
              = diagram([V2/2.1], 3,4,2,
                  diagram([V2/2.2], 5,6,1, prop(-(p2+p3+p4)))
              ) * cycle(2, 1,2) 
                * (1 + permute(3,4,5,6,1,2) + permute(5,6,1,2,3,4));

* The compensating singlet diagram for [D3-3]
global [D3|3] = diagram([V4.p4.1], 1,2,3,
                  diagram([V4.p4.2], 4,5,6, singlet(-(p1+p2+p3)))
                ) * cycle(3, 1,2,3) * cycle(3, 4,5,6);
          


#call diagram(6)

.sort

#call mandel(6)
#call prettymandel(6)

.sort
drop;

*global [M6] = ([D6] + [D3.p6-3] + [D3-3])
*#call group([ZN],6)

*global [M2/4] = ([D2/4] + [D2/1.p6-3] + [D2/1-3])
*#call group([Z2/4],0)
*#include mandelbasis/basis6to24.hf

global [M2/2/2] = ([D2/2/2] + [D2/1-1/2])
#call group([Z2/2/2],0)
;
#include mandelbasis/basis6to222.hf

*global [M3/3]   = [D3|3]
*#call group([Z3/3],0)
*#include mandelbasis/basis6to33.hf

*global [M6p6] = [M6] + [M2/4] + [M2/2/2] + [M3/3];

.sort


*id w3^2 = -(1 + w3);
*id w3 = -(1+w3^2);
#call uncycle

.sort

#call print
.end
