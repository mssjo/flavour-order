
#define NM "10"
#define OP "2"

#include defs.hf
#include init_fo.hf

#if((`NM'==10) && (`OP'==4))

#call fodge(10p4, 10)

*global [M10p4.2] = [M10p4];

*.sort
*skip [M10p4.2];

*#call adler(10,1)

*.sort
*skip [M10p4];

*#call adler(10,3)

*.sort

*#call mandelrand(10,0)

#call prettymandel(10)

#elseif((`NM'==10) && (`OP'==2))

#call fodge(10p2,10)

#call adler(10,1)

#endif

#call print
.end
