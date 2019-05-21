#procedure setmomentum(PL, NM, VERT)
* Equips the fields in a NM-field vertex VERT
* with momenta labeled PL1, PL2, ...

#do I = 1, `NM'
  id once phi(?a, i?) = phi(?a, i, `PL'`I');
#enddo

.sort

#endprocedure
