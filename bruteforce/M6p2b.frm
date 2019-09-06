* Six-point O(p²) propagator diagram
*
*  \        /       
*   \      /          
* ---2----2---   
*   /      \       
*  /        \   
*          
*

#include defs.hf

#call vertex(4,2,`PAR',VL)
#call setflavourindex(a,1,4,VL)
#call setmomentum(p,4,VL)

#call vertex(4,2,`PAR',VR)
#call setflavourindex(a,5,8,VR)
#call setmomentum(q,4,VR)

*#call print()
*.end

#call takederiv()
.sort

#call connect(4,4,VL,VR,M6p2b)

#do I=1,6
  #call pickout(ext`I',p`I'ext,{7-`I'},M6p2b);
#enddo
.sort

#call print
.store
save save/M6p2b.sav M6p2b;

.sort

.end
