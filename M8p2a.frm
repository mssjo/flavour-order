* Eight-point O(p^2) contact diagram
*
*    \  |  /
*     \ | /
*      \|/
* ------X------
*      /|\
*     / | \
*    /  |  \
*

#do PARAM={EXP,MIN,CAY}

#include defs.hf

#call vertex(8,2,`PARAM',M8p2a`PARAM')
#call setflavourindex(a,1,8,M8p2a`PARAM')
#call setmomentum(p,8,M8p2a`PARAM')

#call takederiv()
.sort

#do I=1,8
#call pickout(ext`I',p`I'ext,p,{9-`I'},M8p2a`PARAM')
#enddo
.sort

bracket F, i_, Tr;
print +s;
.store
save save/M8p2a`PARAM'.sav M8p2a`PARAM';

.sort

#enddo

.end
