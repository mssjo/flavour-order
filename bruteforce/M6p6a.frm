* Six-point O(p⁶) contact diagram
*
*  \     /
*   \   /
*    \ /
* ----6----
*    / \
*   /   \
*  /     \
*

#include defs.hf

#call vertex(6,6,`PAR',M6p6a)
#call setflavourindex(a,1,6,M6p6a)
#call setmomentum(p,6,M6p6a)

#call takederiv()
.sort

#do I=1,6
  #call pickout(ext`I',p`I'ext,{7-`I'},M6p6a)
#enddo
.sort

#call print()
.store
save save/M6p6a.sav M6p6a;

.end
