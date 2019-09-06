* Four-point O(p^6) contact diagram
*
*   \   /
*    \ /
*     #
*    / \
*   /   \
*

#include defs.hf

#call vertex(4,6,`PAR',M4p6)
#call setflavourindex(a,1,4,M4p6)
#call setmomentum(p,4,M4p6)

#call takederiv()
.sort

#do I=1,4
#call pickout(ext`I',p`I'ext,p,{5-`I'},M4p6)
#enddo
.sort

multiply replace_(<ext1,a1>,...,<ext4,a4>);
multiply replace_(<p1ext,p1>,...,<p4ext,p4>);

#call strip(4,4)

*#call print()
*.sort

*#call dress(4)

#call mandel(4)
#call prettymandel(4)

*id Tr(?a, t(a1), ?b) = Tr(?a, ?b);
*id Tr(t(a?)) = 0;
*id Tr(t(a1?), t(a2?), t(a3?)) = d(a1,a2,a3) + i_*f(a1,a2,a3);

#call print()
.end
