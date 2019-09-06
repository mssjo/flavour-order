#procedure setflavourindex(F, MIN, MAX, VERT)
* Equips the fields in a vertex VERT with flavour indices
* labeled F and ranging from MIN to MAX, assuming that the vertex
* contains (1 + MIN - MAX) fields.
* The fields are split as M = t(b) * phi(b)  over the given
* flavour indices.

.sort
off statistics;
skip;
nskip `VERT';

#do I = `MIN', `MAX'
  id once Tr(?a, M(?b), ?c) = Tr(?a, `F'`I', ?c) * phi(?b, `F'`I');
#enddo

#endprocedure
