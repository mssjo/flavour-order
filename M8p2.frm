#include defs.hf

load save/M8p2.sav;

local ampl = M8p2;

#call mandel(8)

bracket i_, F, Tr, prop;
print +s;
.sort

*id Tr(?a) = 1;

*bracket i_, F, prop;
*print +s;
*.sort
*drop;
*local res = ampl - ref;

#call adler(8,1)

.sort

*#do I=1,8
*id s`I'{`I'%8+1} = `I'; 
*id s`I'{`I'%8+1}{{`I'+1}%8+1} = 11*`I'; 
*id s`I'{`I'%8+1}{{`I'+1}%8+1}{{`I'+2}%8+1} = 13*`I';
*#enddo

#call prettymandel(8)

bracket i_, F, Tr, prop;
print +s;
.end
