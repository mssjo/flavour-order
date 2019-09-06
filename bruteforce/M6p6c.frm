* Six-point O(p⁶) propagator diagram
* with two O(p⁴) vertices
*
*  \        /       
*   \      /          
* ---4----4---   
*   /      \       
*  /        \         
*

#include defs.hf

#call vertex(4,4,`PAR',VL)
#call setflavourindex(a,1,4,VL)
#call setmomentum(p,4,VL)

#call vertex(4,4,`PAR',VR)
#call setflavourindex(a,5,8,VR)
#call setmomentum(q,4,VR)

#call takederiv()
.sort

#call connect(4,4,VL,VR,M6p6c)

#do I=1,6
  #call pickout(ext`I',p`I'ext,{7-`I'},M6p6c);
#enddo
.sort

#call print
.store
save save/M6p6c.sav M6p6c;

.end
