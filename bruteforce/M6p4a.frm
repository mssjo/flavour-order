* Six-point O(p^4) contact diagram
*
*  \     /
*   \   /
*    \ /
* ----4----
*    / \
*   /   \
*  /     \
*
#include defs.hf

#call vertex(6,4,`PAR',M6p4a)
#call setflavourindex(a,1,6,M6p4a);
#call setmomentum(p,6,M6p4a);

#call takederiv()
.sort

#do I=1,6
#call pickout(ext`I',p`I'ext,{7-`I'},M6p4a);
#enddo
.sort

#call print
.store
save save/M6p4a.sav M6p4a;
.sort

.end

