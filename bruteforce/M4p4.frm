* Four-point O(p^4) contact diagram
*
*   \   /
*    \ /
*     O
*    / \
*   /   \
*

#include defs.hf

#call vertex(4,4,`PAR',M4p4)
#call setflavourindex(a,1,4,M4p4)
#call setmomentum(p,4,M4p4)

#call takederiv()
.sort

#do I=1,4
#call pickout(ext`I',p`I'ext,p,{5-`I'},M4p4)
#enddo
.sort

multiply replace_(<ext1,a1>,...,<ext4,a4>);
multiply replace_(<p1ext,p1>,...,<p4ext,p4>);

#call strip(4,4)

bracket i_, F, L1,...,L4, Tr;
print +s;
.sort

#call mandel(4)
#call prettymandel(4)

bracket F, L1,...,L4, i_, Tr;
print +s;
.end
