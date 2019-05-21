#procedure pickout(I,P,NM,VERT)
* This procedure picks out an index I and a momentum P
* from a vertex by forming all ways to identify one of
* the legs of the vertex with I and P.
*
* - NM is the number of fields in the vertex that have not been
*      picked out yet
* - VERT is an expression containing the vertex

.sort
off statistics;
skip;
nskip `VERT';


* Identifies a product of NM fields with itself
* times the sum of all ways to identify one of them with I and P
* (This clever preprocessor monstrosity is due to Bijnens)
multiply left mark;
id mark
  #do J = 1, `NM'
    *phi(i`J'?, p`J'?)
  #enddo
  = (
    #do J = 1, `NM'
      +delt(p`J', `P')*delt(i`J', `I')*delt(i`J', p`J')
    #enddo
  )
  #do J = 1, `NM'
    *phi(i`J', p`J')
  #enddo
  ;
id mark = 1;

*#message Pickout: `VERT' (`NM')

.sort
skip;
nskip `VERT';


* Eliminates the picked-out fields
id delt(i?, p?) * phi(i?, p?) * preprop(?a, p?, ?b) = preprop(?a, ?b);
id delt(i?, p?) * phi(i?, p?) = 1;

* Identifies indices and momenta
id delt(i?, `I') = replace_(i, `I');
id delt(p?, `P') = replace_(p, `P');

*id Tr(?a, t(i?), ?b) * delt(i?, `I') = Tr(?a, t(`I'), ?b);
*repeat;
*id delt(`PL'1?,`P')*`PL'1?.`P' = delt(`PL'1,`P')*`P'.`P';
*id delt(`PL'1?,`P')*`PL'1?.`PL'1? = delt(`PL'1,`P')*`P'.`P';
*id delt(`PL'1?,`P')*`PL'1?.`PL'0? = delt(`PL'1,`P')*`P'.`PL'0;
*endrepeat;

id delt(?a) = 1;

.sort

#endprocedure
