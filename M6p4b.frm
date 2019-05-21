* Six-point O(p⁴) propagator diagram
*
*  \        /       
*   \      /          
* ---4----2---   
*   /      \       
*  /        \        
*

#include defs.hf

#call vertex(4,4,`PAR',VL)
#call setflavourindex(a,1,4,VL)
#call setmomentum(p,4,VL)

#call vertex(4,2,`PAR',VR)
#call setflavourindex(a,5,8,VR)
#call setmomentum(q,4,VR)

#call takederiv()
.sort

#call connect(4,4,VL,VR,M6p4b)

#do I=1,6
  #call pickout(ext`I',p`I'ext,{7-`I'},M6p4b);
#enddo
.sort


#call print
.store
save save/M6p4b.sav M6p4b;
.sort

.end
