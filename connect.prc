#procedure connect(NM1,NM2,V1,V2,DIAG)
* Connects two vertices with a propagator in all possible ways.
*
* - V1 is the left vertex (propagator momentum outgoing)
* - NM1 is the number of fields in that vertex that have not
*       been picked out yet
* - V2 is the right vertex (propagator momentum incoming)
* - NM2 is the number of fields in that vertex that have not
*       been picked out yet
* - DIAG will be the name of the connected expression
*
* V1 and V2 may be either single vertices or sub-diagrams; this procedure
* treats both cases equally. External legs should not have been picked out
* before calling this procedure.

.sort
skip;
nskip `V1';

* Multiplies V1 with preprop, which contains all ingoing momenta to the left-hand
* side. Eventually, preprop will contain the propagator momentum and become prop.
multiply left preprop();
id preprop()
  #do I=1, `NM1'
    *phi(i`I'?, p`I'?)
  #enddo
  = 1
  #do I=1, `NM1'
    *phi(i`I', p`I')
  #enddo
  * preprop(p1
    #do I=2, `NM1'
      ,p`I'
    #enddo
  );
  
.sort

* Picks out the legs that will form the propagator in all possible ways.
* This also removes the picked-out momentum from preprop
#call pickout(ip,ok,`NM1',`V1')
#call pickout(ip,ik,`NM2',`V2')

* Summing the arguments of preprop leaves the propagator momentum inside it.
repeat id preprop(p?, q?, ?a) = preprop(p+q, ?a);

.sort
drop `V1', `V2';

* Forms the connected expression.
global `DIAG' = i_ * `V1' * `V2';

.sort
skip;
nskip `DIAG';

* Substitutes the propagator momentum
id preprop(p?) = prop(p) * replace_(ok, -p, ik, p);

* Contracts the traces
id Tr(?a, ip) * Tr(ip, ?b) = Tr(?a, ?b) - 1/Nf * Tr(?a) * Tr(?b);
id Tr(i?) = 0;

.sort

#endprocedure
