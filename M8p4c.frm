* Eight-point O(p^4) one-propagator diagram
* (O(p^2) 4-point vertex connected to O(p^4) 6-point vertex)
*
*    \1       |8 /7
*     \       | /
*      \      |/
* 2 ----X-----O----
*      / -->k |\   6
*     /       | \
*   3/       4| 5\
*

*#do PARAM={EXP,MIN,CAY}
#do PARAM={CAY}

#include defs.hf

#call vertex(4,2,`PARAM',VL`PARAM')
#call setflavourindex(a,1,4,VL`PARAM')
#call setmomentum(p,4,VL`PARAM')

#call vertex(6,4,`PARAM',VR`PARAM')
#call setflavourindex(a,5,10,VR`PARAM')
#call setmomentum(q,6,VR`PARAM')

#call takederiv()
.sort

#do I=1,3
#call pickout(ext`I',p`I'ext,p,{5-`I'},VL`PARAM')
#enddo
#do I=4,8
#call pickout(ext`I',p`I'ext,q,{10-`I'},VR`PARAM')
#enddo
.sort

#call connect(k,1,1,VL`PARAM',VR`PARAM',M8p4c`PARAM')
id prop(k) = prop(p1ext,p2ext,p3ext);
id k = -(p1ext+p2ext+p3ext);

id p?.p? = 0;

bracket F, i_, Tr, prop;
print +s;
.store
save save/M8p4c`PARAM'.sav M8p4c`PARAM';

.sort

#enddo

.end
