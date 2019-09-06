* Eight-point O(p^4) two-propagator diagram
* (three 4-point vertices, first (or last) is O(p^4))
*
*    \1       |5       /8   
*     \       |       /
*      \      |      /    
* 2 ----O-----X-----X-----  +  ( OXX <-> XXO )
*      / -->k | l<-- \   7
*     /       |       \
*   3/        |4      6\
*

*#do PARAM={EXP,MIN,CAY}
#do PARAM={CAY}

#include defs.hf

#call vertex(4,4,`PARAM',VL`PARAM')
#call setflavourindex(a,1,4,VL`PARAM')
#call setmomentum(p,4,VL`PARAM')

#call vertex(4,2,`PARAM',VC`PARAM')
#call setflavourindex(a,5,8,VC`PARAM')
#call setmomentum(q,4,VC`PARAM')

#call vertex(4,2,`PARAM',VR`PARAM')
#call setflavourindex(a,9,12,VR`PARAM')
#call setmomentum(r,4,VR`PARAM')

#call takederiv()
.sort

#do I=1,3
#call pickout(ext`I',p`I'ext,p,{5-`I'},VL`PARAM')
#enddo
#do I=4,5
#call pickout(ext`I',p`I'ext,q,{8-`I'},VC`PARAM')
#enddo
#do I=6,8
#call pickout(ext`I',p`I'ext,r,{10-`I'},VR`PARAM')
#enddo
.sort

#call connect(k,1,2,VL`PARAM',VC`PARAM',VLC`PARAM')
#call connect(l,1,1,VR`PARAM',VLC`PARAM',M8p4d`PARAM')
id prop(k) = prop(p1ext,p2ext,p3ext);
id k = -(p1ext+p2ext+p3ext);
id prop(l) = prop(p6ext,p7ext,p8ext);
id l = -(p6ext+p7ext+p8ext);

id p?.p? = 0;

* Multiplicity!
multiply 2;

bracket F, i_, Tr;
print +s;
.store
save save/M8p4d`PARAM'.sav M8p4d`PARAM';

.sort

#enddo

.end
