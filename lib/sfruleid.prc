#procedure sfruleid(NM, NP, SFR, VID)
* Creates a stripped vertex Feynman rule with a manually set vertex ID. 
* - NM is the number of fields in the vertex
* - NP is the order in momenta
* - SFR is the name of the expression that will be created
*   to hold the rule
* - VID is the vertex ID number used when building diagrams.
*
* The momenta will be labeled [pVID.1], [pVID.2], etc., with the
* period preventing confusion with multiple-digit numbers.
* The flavour indices will similarly labeled [fVID.1], [fVID.1] etc. 
* This ensures that all indices and momenta are unique when diagrams 
* are constructed.
*
* In order to generate split-trace rules, the parameter SPLIT
* should be set to split(n1,n2,...) as described in split.prc;
* in order not to split the traces, SPLIT should be set to 
* either split(NM) or nosplit.

#do I=1,`NM'
  symbol [f`VID'.`I'];
  vector [p`VID'.`I'];
#enddo
set [fs`VID'] : <[f{`VID'}.1]>,...,<[f{`VID'}.{`NM'}]>;
set [ps`VID'] : <[p{`VID'}.1]>,...,<[p{`VID'}.{`NM'}]>;

* If RERUNVERT is false, we don't rerun the calculation below.
* We still define the symbols and increment the vertid, so that
* the pre-computed vertex factors can be used correctly.
#if(`RERUNVERT')

* Creates the vertex factor
#call vertex(`NM',`NP',`PAR',`SFR')

.sort
skip;
nskip `SFR';

* Simple equal-mass case
*id Tr(chi(?l), ?a) = chi(?l) * Tr(?a);
*id chi(dag) = chi;

.sort 


*#define OLDPICKOUT "0"
*#if(`OLDPICKOUT')
*#call setflavourindex(a,`FLAVIDX',{`FLAVIDX'+`NM'-1},`SFR')
*#call setmomentum(p,`NM',`SFR')
*
*#call takederiv();
*.sort
*
** It is difficult to replace this slow thing with something that takes
** more advantage of flavour ordering, since the traces can be reordered
** in not entirely trivial ways.
*#do J=0,{`NM'-1}
*  #call pickout(b{`FLAVIDX'+`J'},q{`FLAVIDX'+`J'},p,{`NM'-`J'},`SFR')
*#enddo
*
* Problem now solved - OLDPICKOUT is deprecated!
*#else

#call flavourorder(`NM',`SFR',`VID')
*#endif

.sort
skip;
nskip `SFR';

* This is a tag telling diagram.prc the index of the vertex
multiply left vertid(`VID');

#message Stripped O(p^`NP') `NM'-point vertex 
#message with flavour structure `SPLIT'
#message (vertex ID: `VID')

*#call split(`NM',`VID')
*skip;
*nskip `SFR';

#call print()
.sort

* -- RERUNVERT --
#endif

#redefine VERTID "{`VERTID'+1}"

#endprocedure
