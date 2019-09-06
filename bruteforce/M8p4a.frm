* Eight-point O(p^4) contact diagram
*
*    \  |  /
*     \ | /
*      \|/
* ------O------
*      /|\
*     / | \
*    /  |  \
*

*#do PARAM={EXP,MIN,CAY}
#do PARAM={CAY}

#include defs.hf

#call vertex(8,4,`PARAM',M8p4a`PARAM')
#call setflavourindex(a,1,8,M8p4a`PARAM')
#call setmomentum(p,8,M8p4a`PARAM')

#call takederiv()
.sort

#do I=1,8
#call pickout(ext`I',p`I'ext,p,{9-`I'},M8p4a`PARAM')
#enddo
.sort

bracket F, L1,...,L4, i_, Tr;
print +s;
.store
save save/M8p4a`PARAM'.sav M8p4a`PARAM';

.sort

#enddo

.end
