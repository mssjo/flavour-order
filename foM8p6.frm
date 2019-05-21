#include defs.hf
#include init_fo.hf

#call sfrule(4,2,[V4.1])
#call sfrule(4,2,[V4.2])
#call sfrule(4,4,[V4.p4.1])
#call sfrule(4,4,[V4.p4.2])
#call sfrule(4,6,[V4.p6])

#call sfrule(6,2,[V6])
#call sfrule(6,4,[V6.p4])
#call sfrule(6,6,[V6.p6])

#redefine SPLIT "split(2,2)"
#call sfrule(4,4,[V2/2.1])
#call sfrule(4,4,[V2/2.2])
#call sfrule(4,6,[V2/2.p6])

#redefine SPLIT "split(2,4)"
#call sfrule(6,4,[V2/4])
#call sfrule(6,6,[V2/4.p6])

#redefine SPLIT "split(3,3)"
#call sfrule(6,6,[V3/3.p6])

#redefine SPLIT "split(2,2,2)"
#call sfrule(6,6,[V2/2/2])

#redefine SPLIT "unsplit"
#call sfrule(8,6,[V8.p6])

#redefine SPLIT "split(2,6)"
#call sfrule(8,6,[V2/6.p6])

#redefine SPLIT "split(3,5)"
#call sfrule(8,6,[V3/5.p6])

#redefine SPLIT "split(4,4)"
#call sfrule(8,6,[V4/4.p6])

#redefine SPLIT "split(2,2,4)"
#call sfrule(8,6,[V2/2/4])

*This vertex vanishes, just like [V3/3] at O(p⁴)
*#redefine SPLIT "split(2,3,3)"
*#call sfrule(8,6,[V2/3/3])

*#call print()
*.end
.sort;
drop;

*** Contact diagrams
global [D8]     = diagram(vertid(16), 1,...,8) * [V8.p6];
global [D2/6]   = diagram(vertid(17), 1,...,8) * [V2/6.p6];
global [D3/5]   = diagram(vertid(18), 1,...,8) * [V3/5.p6];
global [D4/4]   = diagram(vertid(19), 1,...,8) * [V4/4.p6];
global [D2/2/4] = diagram(vertid(20), 1,...,8) * [V2/2/4];

*** O(p⁶) - O(p²) one-propagator diagrams
global [D3.p6-5] 
              = diagram([V4.p6], 1,2,3, 
                  diagram([V6], 4,5,6,7,8, prop(-(p1+p2+p3)))
              ) * cycle(8, 1,...,8);
global [D3-5.p6]    
              = diagram([V4.1], 1,2,3, 
                  diagram([V6.p6], 4,5,6,7,8, prop(-(p1+p2+p3)))
              ) * cycle(8, 1,...,8);
global [D2/1.p6-5]
              = diagram([V2/2.p6], 1,2, 3,
                  diagram([V6], 4, 5,6,7,8,prop(-(p1+p2+p3)))
              ) * cycle(6, 3,...,8);
global [D3-3/2.p6]
              = diagram([V4.1], 3,4,5,
                  diagram([V2/4.p6], 1,2, 6,7,8,prop(-(p3+p4+p5)))
              ) * cycle(6, 3,...,8);
global [D3-2/3.p6]
              = diagram([V4.1], 4,5,6
                  diagram([V3/3.p6], 1,2,3, 7,8,prop(-(p4+p5+p6)))
              ) * cycle(5, 4,...,8);
* Two flavour-equivalent versions: 1,...,4 straddling the propagator or not
global [D3-1/4.p6]    
              = diagram([V4.1], 1,2,3, 
                  diagram([V2/4.p6], prop(-(p1+p2+p3)),4, 5,6,7,8)
              ) * cycle(4, 1,...,4)
                * (1 + permute(5,...,8, 1,...,4));
global [D3-1/2/2]
              = diagram([V4.1], 5,6,7
                  diagram([V2/2/2], 1,2, 3,4, prop(-(p5+p6+p7)), 8)
              ) * cycle(4, 5,...,8);


*** O(p⁴) - O(p⁴) one-propagator diagrams
global [D3-5] = diagram([V4.p4.1], 1,2,3,
                  diagram([V6.p4], 4,...,8, prop(-(p1+p2+p3)))
              ) * cycle(8, 1,...,8);
global [D3-3/2] 
              = diagram([V4.p4.1], 3,4,5,
                  diagram([V2/4], 1,2, 6,7,8,prop(-(p3+p4+p5)))
              ) * cycle(6, 3,...,8);
* Two flavour-equivalent versions of this diagram!
global [D3-1/4]
              = diagram([V4.p4.1], 1,2,3,
                  diagram([V2/4], prop(-(p1+p2+p3)),4, 5,6,7,8)
              ) * cycle(4, 1,...,4)
                * (1 + permute(5,...,8, 1,...,4));

global [D2/1-5]
              = diagram([V2/2.1], 1,2, 3,
                  diagram([V6.p4], 4,5,6,7,8,prop(-(p1+p2+p3)))
              ) * cycle(6, 3,...,8);
* Note the peculiar order used to maintain the flavour structure
* <12><34><5678> rather than <12><3456><78>
* Also, two flavour-equivalent versions with 12 on different sides
* of the nonsymmetric diagram
global [D2/1-3/2]
              = diagram([V2/2.1], 1,2, 8,
                  diagram([V2/4], 3,4, 5,6,7,prop(-(p8+p1+p2)))
              ) * cycle(4, 5,...,8)
                * (1 + permute(3,4, 1,2, 5,...,8));
* This one is similar to the above, but with 12 straddling the propagator
global [D2/1-1/4]
              = diagram([V2/2.1], 1,2, 3,
                  diagram([V2/4], prop(-(p1+p2+p3)),4, 5,6,7,8)
              ) * cycle(2, 3,4)
                * (1 + permute(3,4, 1,2, 5,...,8));

*** O(p²) - O(p⁶) - O(p²) two-propagator diagrams
global [D3-2t.p6-3]
              = diagram([V4.p6],
                  diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                4,
                  diagram([V4.2], 5,6,7, prop(p5+p6+p7)),
                8) * cycle(4, 1,...,8);
global [D3-2c.p6-3]
              = diagram([V4.p6],
                  diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                  diagram([V4.2], 4,5,6, prop(p4+p5+p6)),
                7,8) * cycle(8, 1,...,8);
global [D3-1/1.p6-3]
              = diagram([V2/2.p6], 1,
                  diagram([V4.1], 2,3,4, prop(p2+p3+p4)), 
                5,
                  diagram([V4.2], 6,7,8, prop(p6+p7+p8))
              ) * cycle(4, 1,...,4) * cycle(4, 5,...,8);
global [D3-0(/2.p6)-3]
              = diagram([V2/2.p6], 1,2,
                  diagram([V4.1], 3,4,5, prop(p3+p4+p5)),
                  diagram([V4.2], 6,7,8, prop(p6+p7+p8))
              ) * cycle(3, 3,...,8);

*** O(p²) - O(p²) - O(p⁶) two-propagator diagrams 
*** (all require both cis, trans and uls forms)
global [D3-2t-3.p6] 
              = diagram([V4.2],
                  diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                4,
                  diagram([V4.p6], 5,6,7, prop(p5+p6+p7)),
                8) * cycle(8, 1,...,8);
global [D3-2c-3.p6] 
              = diagram([V4.2],
                  diagram([V4.1], 1,2,3, prop(p1+p2+p3)),
                  diagram([V4.p6], 4,5,6, prop(p4+p5+p6)),
                7,8) * cycle(8, 1,...,8);
global [D3-2u-3.p6]
              = diagram([V4.2],
                  diagram([V4.1], 1,2,3, prop(p1+p2+p3)), 
                4,5,
                  diagram([V4.p6], 6,7,8, prop(p6+p7+p8))
                ) * cycle(8, 1,...,8);
global [D3-2t-1/2.p6]
              = diagram([V4.2],
                  diagram([V4.1], 5,6,7, prop(p5+p6+p7)),
                8,
                  diagram([V2/2.p6], 1,2,3, prop(p1+p2+p3)),
                4) * cycle(6, 3,...,8);
global [D3-2c-1/2.p6]
              = diagram([V4.2],
                  diagram([V4.1], 6,7,8, prop(p6+p7+p8)),
                  diagram([V2/2.p6], 1,2,3, prop(p1+p2+p3)),
                4,5) * cycle(6, 3,...,8);
global [D3-2u-1/2.p6]
              = diagram([V4.2],
                  diagram([V4.1], 4,5,6, prop(p4+p5+p6)), 
                7,8,
                  diagram([V2/2.p6], 1,2,3, prop(p1+p2+p3))
                ) * cycle(6, 3,...,8);

*** O(p⁴) - O(p²) - O(p⁴) two-propagator diagrams
global [D3.p4-2t-3.p4]
              = diagram([V4.1],
                  diagram([V4.p4.1], 1,2,3, prop(p1+p2+p3)), 
                4,
                  diagram([V4.p4.2], 5,6,7, prop(p5+p6+p7)),
                8) * cycle(4, 1,...,8);
global [D3.p4-2c-3.p4]
              = diagram([V4.1],
                  diagram([V4.p4.1], 1,2,3, prop(p1+p2+p3)), 
                  diagram([V4.p4.2], 4,5,6, prop(p4+p5+p6)),
                7,8) * cycle(8, 1,...,8);
global [D2/1-2t-3.p4]
              = diagram([V4.1],
                  diagram([V2/2.1], 1,2, 3, prop(p1+p2+p3)), 
                4,
                  diagram([V4.p4.2], 5,6,7, prop(p5+p6+p7)),
                8) * cycle(6, 3,...,8);
global [D2/1-2c-3.p4]
              = diagram([V4.1],
                  diagram([V2/2.1], 1,2,3, prop(p1+p2+p3)), 
                  diagram([V4.p4.2], 4,5,6, prop(p4+p5+p6)),
                7,8) * cycle(6, 3,...,8);
global [D2/1-2u-3.p4]
              = diagram([V4.1],
                  diagram([V2/2.1], 1,2,3, prop(p1+p2+p3)),
                4,5,
                  diagram([V4.p4.2], 6,7,8, prop(p6+p7+p8))
                ) * cycle(6, 3,...,8);
global [D2/1-2t-1/2]
              = diagram([V4.1],
                  diagram([V2/2.1], 1,2, 5, prop(p1+p2+p5)), 
                6,
                  diagram([V2/2.2], 3,4, 7, prop(p3+p4+p7)),
                8) * cycle(4, 5,...,8);
* Two flavour-equivalent versions - the second replaces the uls form
global [D2/1-2c-1/2]
              = diagram([V4.1],
                  diagram([V2/2.1], 1,2, 5, prop(p1+p2+p5)), 
                  diagram([V2/2.2], 3,4, 6, prop(p3+p4+p6)),
                7,8) * cycle(4, 5,...,8)
                * (1 + permute(3,4, 1,2, 5,...,8));

*** O(p⁴) - O(p⁴) - O(p²) two-propagator diagrams
global [D3.p4-2t.p4-3]
              = diagram([V4.p4.2],
                  diagram([V4.p4.1], 1,2,3, prop(p1+p2+p3)), 
                4,
                  diagram([V4.1], 5,6,7, prop(p5+p6+p7)),
                8) * cycle(8, 1,...,8);
global [D3.p4-2c.p4-3]
              = diagram([V4.p4.2],
                  diagram([V4.p4.1], 1,2,3, prop(p1+p2+p3)), 
                  diagram([V4.1], 4,5,6, prop(p4+p5+p6)),
                7,8) * cycle(8, 1,...,8);
global [D3.p4-2u.p4-3]
              = diagram([V4.p4.2],
                  diagram([V4.p4.1], 1,2,3, prop(p1+p2+p3)), 
                4,5
                  diagram([V4.1], 6,7,8, prop(p6+p7+p8))
                ) * cycle(8, 1,...,8);
global [D2/1-2t.p4-3]
              = diagram([V4.p4.1],
                  diagram([V2/2.1], 1,2,3, prop(p1+p2+p3)), 
                4,
                  diagram([V4.1], 5,6,7, prop(p5+p6+p7)),
                8) * cycle(6, 3,...,8);
global [D2/1-2c.p4-3]
              = diagram([V4.p4.1],
                  diagram([V2/2.1], 1,2,3, prop(p1+p2+p3)), 
                  diagram([V4.1], 4,5,6, prop(p4+p5+p6)),
                7,8) * cycle(6, 3,...,8);
global [D2/1-2u.p4-3]
              = diagram([V4.p4.1],
                  diagram([V2/2.1], 1,2,3, prop(p1+p2+p3)), 
                4,5
                  diagram([V4.1], 6,7,8, prop(p6+p7+p8))
                ) * cycle(6, 3,...,8);
global [D3.p4-0(/2)-3]
              = diagram([V2/2.1], 1,2,
                  diagram([V4.p4.1], 3,4,5, prop(p3+p4+p5)),
                  diagram([V4.1], 6,7,8, prop(p6+p7+p8))
              ) * cycle(6, 3,...,8);
* Two flavour-equivalent versions - 1,2 on the O(p⁴) or O(p²) side
global [D3.p4-1/1-3]
              = diagram([V2/2.1], 1,
                  diagram([V4.p4.1], 2,3,4, prop(p2+p3+p4)),
                5,
                  diagram([V4.1], 6,7,8, prop(p6+p7+p8))
              ) * cycle(4, 1,...,4) * cycle(4, 5,...,8)
                * (1 + permute(5,...,8, 1,...,4));
* Two flavour-equivalent versions - 1,2 in the middle or on the end
global [D2/1-0(/2)-3]
              = diagram([V2/2.2], 1,2,
                  diagram([V2/2.1], 3,4, 5, prop(p3+p4+p5)),
                  diagram([V4.1], 6,7,8, prop(p6+p7+p8))
              ) * cycle(4, 5,...,8)
                * (1 + permute(3,4, 1,2, 5,...,8));
* Two flavour-equivalent versions - 1,2 straddling a propagator or not
global [D2/1-1/1-3]
              = diagram([V2/2.2], 4,
                  diagram([V2/2.1], 1,2, 3, prop(p1+p2+p3)),
                5,
                  diagram([V4.1], 6,7,8, prop(p6+p7+p8))
              ) * cycle(4, 5,...,8) * cycle(2, 3,4)
                * (1 + permute(3,4, 1,2, 5,...,8));

*** Compensating singlet diagrams
global [D3|5] = diagram([V4.p4.1], 1,2,3,
                  diagram([V6.p4], 4,...,8, singlet(-(p1+p2+p3)))
                ) * cycle(3, 1,2,3) * cycle(5, 4,...,8);
global [D3|3/2]
              = diagram([V4.p4.1], 3,4,5,
                  diagram([V2/4], 1,2, 6,7,8, singlet(-(p3+p4+p5)))
                ) * cycle(3, 3,4,5) * cycle(3, 6,7,8);
global [D3|2t-3]
              = diagram([V4.p4.2],
                  diagram([V4.p4.1], 1,2,3, singlet(p1+p2+p3)), 
                4,
                  diagram([V4.1], 5,6,7, prop(p5+p6+p7)),
                8) * cycle(3, 1,2,3) * cycle(5, 4,...,8);
global [D3|2c-3]
              = diagram([V4.p4.2],
                  diagram([V4.p4.1], 1,2,3, singlet(p1+p2+p3)), 
                  diagram([V4.1], 4,5,6, prop(p4+p5+p6)),
                7,8) * cycle(3, 1,2,3) * cycle(5, 4,...,8);
global [D3|2u-3]
              = diagram([V4.p4.2],
                  diagram([V4.p4.1], 1,2,3, singlet(p1+p2+p3)), 
                4,5
                  diagram([V4.1], 6,7,8, prop(p6+p7+p8))
                ) * cycle(3, 1,2,3) * cycle(5, 4,...,8);
global [D3|0(/2)-3]
              = diagram([V2/2.1], 1,2,
                  diagram([V4.p4.1], 3,4,5, singlet(p3+p4+p5)),
                  diagram([V4.1], 6,7,8, prop(p6+p7+p8))
              ) * cycle(3, 3,4,5) * cycle(3, 6,7,8);
        
#call diagram(8)

#call print
*.end
.sort


*if(match(Tr(a1?,a2?,a3?,a4?)*Tr(a5?,a6?,a7?,a8?)) == 0)
*  discard;
*.sort

drop;
global [M8p6] =
    [D8] + [D2/6] + [D3/5] + [D4/4] + [D2/2/4]
  + [D3.p6-5] + [D2/1.p6-5] 
    + [D3-5.p6] + [D3-1/4.p6] + [D3-2/3.p6] + [D3-3/2.p6] + [D3-1/2/2]
  + [D3-5] + [D3-3/2] + [D3-1/4] + [D2/1-5] + [D2/1-3/2] + [D2/1-1/4]
  + [D3-2t.p6-3] + [D3-2c.p6-3] + [D3-0(/2.p6)-3] + [D3-1/1.p6-3]
  + [D3-2t-3.p6] + [D3-2c-3.p6] + [D3-2u-3.p6] 
    + [D3-2t-1/2.p6] + [D3-2c-1/2.p6] + [D3-2u-1/2.p6]
  + [D3.p4-2t-3.p4] + [D3.p4-2c-3.p4] 
    + [D2/1-2t-3.p4] + [D2/1-2c-3.p4] + [D2/1-2u-3.p4]
    + [D2/1-2t-1/2] + [D2/1-2c-1/2]
  + [D3.p4-2t.p4-3] + [D3.p4-2c.p4-3] + [D3.p4-2u.p4-3]
    + [D2/1-2t.p4-3] + [D2/1-2c.p4-3] + [D2/1-2u.p4-3]
    + [D3.p4-0(/2)-3] + [D3.p4-1/1-3]
    + [D2/1-0(/2)-3] + [D2/1-1/1-3]
  - [D3|5] - [D3|3/2] - [D3|2t-3] - [D3|2c-3] - [D3|2u-3] - [D3|0(/2)-3]
;

#call print
.sort

#call mandel(8)
*#call adler(8,8)
#call prettymandel(8)
*#call mandelrand(8, 0);



#call print
.end
