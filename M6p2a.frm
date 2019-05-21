* Six-point O(p²) contact diagram
*
*  \     /
*   \   /
*    \ /
* ----2----
*    / \
*   /   \
*  /     \
*

#include defs.hf

#call vertex(6,2,`PAR',M6p2a)

*#call print()
*.end

#call setflavourindex(a,1,6,M6p2a);
#call setmomentum(p,6,M6p2a);

#call takederiv()
.sort

#do I=1,6
#call pickout(ext`I',p`I'ext,{7-`I'},M6p2a);
#enddo
.sort

#call print;
.store
save save/M6p2a.sav M6p2a;

.sort

.end
