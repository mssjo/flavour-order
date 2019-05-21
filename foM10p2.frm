#include defs.hf
#include init_fo.hf

#call sfrule(10,2,[V10])

#call sfrule(8,2,[V8])

#call sfrule(6,2,[V6.1])
#call sfrule(6,2,[V6.2])

#call sfrule(4,2,[V4.1])
#call sfrule(4,2,[V4.2])
#call sfrule(4,2,[V4.3])
#call sfrule(4,2,[V4.4])

.sort
drop;

*** Contact diagram
global [D10]     = diagram(vertid(1), 1,...,10) * [V10];

*** One-propagator diagrams
global [D3-7]    = diagram([V4.1], 1,2,3,
                     diagram([V8], 4,...,10, prop(p4+...+p10))
                   ) * cycle(10, 1,...,10);
global [D5-5]    = diagram([V6.1], 1,...,5,
                     diagram([V6.2], 6,...,10, prop(p6+...+p10))
                   ) * cycle(5, 1,...,10);

*** Two-propagator diagrams
global [D3-2t-5] = diagram([V4.2],
                     diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                   4,
                     diagram([V6.1], 5,...,9, prop(p5+...+p9)),
                   10) * cycle(10, 1,...,10);
global [D3-2c-5] = diagram([V4.2],
                     diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                     diagram([V6.1], 4,...,8, prop(p4+...+p8)),
                   9,10) * cycle(10, 1,...,10);
global [D3-2u-5] = diagram([V4.2],
                     diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                   4,5,
                     diagram([V6.1], 6,...,10, prop(p6+...+p10))
                   ) * cycle(10, 1,...,10);
global [D3-4t-3] = diagram([V6.1],
                     diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                   4,5,
                     diagram([V4.2], 6,7,8, prop(p6+p7+p8)),
                   9,10) * cycle(5, 1,...,10);
global [D3-4c-3] = diagram([V6.1],
                     diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                   4,
                     diagram([V4.2], 5,6,7, prop(p5+p6+p7)),
                   8,9,10) * cycle(10, 1,...,10);
* A doubly cis diagram - trans (equal number on both sides) is seen as default,
* since that's how non-flavour-ordered diagrams are conventionally drawn.
global [D3-4cc-3] 
                 = diagram([V6.1],
                     diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                     diagram([V4.2], 4,5,6, prop(p4+p5+p6)),
                   7,8,9,10) * cycle(10, 1,...,10);

*** Straight three-propagator diagrams
global [D3-2t-2t-3]
                 = diagram([V4.2],
                     diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                   4,
                     diagram([V4.3], prop(p5+...+p9), 
                     5,
                       diagram([V4.4], 6,7,8, prop(p6+p7+p8)),
                     9),
                   10) * cycle(5, 1,...,10);
global [D3-2c-2t-3]
                 = diagram([V4.2],
                     diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                     diagram([V4.3], prop(p4+...+p8), 
                     4,
                       diagram([V4.4], 5,6,7, prop(p5+p6+p7)),
                     8),
                   9,10) * cycle(10, 1,...,10);
* u-t is equivalent to t-c here by a half-cycle 
global [D3-2u-2t-3]
                 = diagram([V4.2],
                     diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                   4,5,
                     diagram([V4.3], prop(p6+...+p10), 
                     6,
                       diagram([V4.4], 7,8,9 prop(p7+p8+p9)),
                     10)
                   ) * cycle(10, 1,...,10);
global [D3-2c-2c-3]
                 = diagram([V4.2],
                     diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                     diagram([V4.3], prop(p4+...+p8),
                       diagram([V4.4], 4,5,6, prop(p4+p5+p6)),
                     7,8),
                   9,10) * cycle(10, 1,...,10);
global [D3-2c-2u-3]
                 = diagram([V4.2],
                     diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                     diagram([V4.3], prop(p4+...+p8), 
                     4,5,
                       diagram([V4.4], 6,7,8, prop(p6+p7+p8))
                     ),
                   9,10) * cycle(5, 1,...,10);
global [D3-2u-2c-3]
                 = diagram([V4.2],
                     diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                   4,5,
                     diagram([V4.3], prop(p6+...+p10),
                       diagram([V4.4], 6,7,8, prop(p6+p7+p8)),
                     9,10)
                   ) * cycle(5, 1,...,10);

*** Branched three-propagator diagram
global [D3-1(-3)-3]
                 = diagram([V4.1],
                     diagram([V4.2], 1,2,3, prop(p1+p2+p3)),
                     diagram([V4.3], 4,5,6, prop(p4+p5+p6)),
                     diagram([V4.4], 7,8,9, prop(p7+p8+p9)),
                   10) * cycle(10, 1,...,10);

.sort

#call diagram(10)

#call mandel(10)

drop;
global [M10p2] = 
   [D10] 
 + [D3-7] + [D5-5]
 + [D3-2t-5] + [D3-2c-5] + [D3-2u-5] 
   + [D3-4t-3] + [D3-4c-3] + [D3-4cc-3] 
 + [D3-2t-2t-3] + [D3-2c-2t-3] + [D3-2u-2t-3] 
   + [D3-2c-2c-3] + [D3-2c-2u-3] + [D3-2u-2c-3]
 + [D3-1(-3)-3]
;

.sort

#call adler(10,1)
*#call uncycle(10,1)
#call prettymandel(10)

#call print
.end
