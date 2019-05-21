#procedure diagram(NM)
* Creates flavour-ordered Feynman diagrams from diagram specifications.
* A diagram specification consists of the expression
*  diagram(vert, ...)
* where vert is the name of an n-point vertex created by sfrule, and
* ... are n arguments corresponding, in cyclic order, to the legs of the vertex.
* Each argument can be:
* - A number i between 1 and NM, which causes this leg to be identified 
*   with the ith external leg of the diagram.
* - Another diagram specification, which turns this leg into a propagator
*   connecting to the sub-diagram created by that specification.
* - An instance of prop(K), which turns this leg into the other end of the
*   propagator that connects this sub-diagram to its parent diagram.
*   K should be the momentum in the propagator going OUT OF this sub-diagram
*   (i.e. the sum of all momenta on THIS side of the propagator, or MINUS 
*    the sum of all momenta on THE OTHER side). There can be only one prop(K)
*   in each nesting of diagram(...), and none at all in the outermost one.
* - An instance of singlet(K), which represents a U(1) singlet propagator. 
*   It acts kinematically like prop(K), but the flavour structures are not
*   connected at the propagator, and the propagator is multiplied by 1/Nf. 
*   Subtracting all nonvanishing singlet diagrams transforms a U(Nf) amplitude 
*   into an SU(Nf) one.
*
* Before making vertex specifications, all vertices must be created by using
* sfrule. Two vertices with the same vertex ID may never be part of
* the same diagram.
*
* Some very large vertex factors do not like being put inside a function.
* Instead, they can simply be multiplied outside the diagram specification,
* and vertid(i) be inserted in its place as an argument. Here, i is the 
* vertex ID assigned to the vertex when it was created. 
* Using vertid reduces readability, and should be used as a last resort.
*
* Before calling this procedure, the diagram specification should, if needed,
* be multiplied by one or more cycle() functions to indicate the correct cyclings
* of the external legs, and a sum of permute() functions to indicate shuffling of
* the flavour-disconnected groups. This procedure will execute cycl.prc followed 
* by permute.prc as needed.
*
* For example, the two-propagator contribution to the O(p²) 8-point scattering
* (laboriously written in fM8p2c.frm) is given by
*   diagram(V2, 
*     diagram(V1, 1,2,3, prop(p1+p2+p3)),
*   4, 
*     diagram(V3, 5,6,7, prop(p5+p6+p7)),
*   8) * cycle(4, 1,...,8)
* for the "trans" or "|" arrangement of the middle vertex, and
*   diagram(V2,
*     diagram(V1, 1,2,3, prop(p1+p2+p3)),
*     diagram(V3, 4,5,6, prop(p4+p5+p6)),
*   7,8) * cycle(8, 1,...,8)
* for the "cis" or "\/" arrangement. (Sometimes, the diagram is so nonsymmetric
* that we also need to consider the "uls" or "/\" arrangement, in which
* both 4 and 5 are placed before the second sub-diagram.) In both cases, the 
* middle vertex is chosen to be the outermost nesting, but this is not the only 
* possible choice. V1,V2,V3 are all created with 
*   #call sfrule(4,2,Vx)
* using SPLIT set to nosplit.
*

* Adds a counter that keeps track of the propagator numbers.
* Each time a propagator is started, its momentum is given an number
* matched by its child sub-diagram, so that it can be connected back.
id diagram(?a) = counter(1) * diagram(0, ?a);

* Prevents vertid on external vertices from interfering
id vertid(i?) = 1;

* The maximum number of repetitions is 3/2 * NM - 2:
* NM legs, and NM/2 - 1 propagators.
#do I=1,{{3*`NM'}/2 - 1}

* Removes diagrams containing vertex factors that are zero.
  id diagram(pid?, 0, ?a) = 0;

* Sets up vertices and vertex IDs; from now on, explicit vertices
* and references through vertid are the same.
* The resulting structure is
*   diagram(
*     <parent propagator number>,
*     <vertex ID>,
*     <flavour index counter>,
*     <specifications ... >
*   ) * <vertex factor>
  id diagram(pid?, vertex?!int_, ?a)  = diagram(pid, ?a) * vertex;
  id diagram(pid?, ?a) * vertid(vid?) = diagram(pid, vid, 1, ?a);
  id diagram(pid?, vertid(vid?), ?a)  = diagram(pid, vid, 1, ?a);

* Sets up external leg substitutions: 
* internal leg (vid,i) becomes external leg j
  id diagram(pid?, vid?, i?, j?int_, ?a) 
    = replace(vid, i, j) * diagram(pid, vid, i+1, ?a);

* Sets up propagators:
* internal leg (vid,i) becomes (the outgoing end of) propagator pid
  id diagram(pid?, vid?, i?, prop(k?), ?a)
    = i_ * prop(k) * rf([f](vid,i), is[pid]) * rp([p](vid,i), -ks[pid])
      * replace_(ks[pid], k)
      * diagram(pid, vid, i+1, ?a);

*   Sets up singlet propagators similarly
  id diagram(pid?, vid?, i?, singlet(k?), ?a)
    = i_/Nf * prop(k) * rf([f](vid,i), 0) * rp([p](vid,i), -ks[pid])
      * replace_(ks[pid], k)
      * replace_(is[pid], 0)
      * diagram(pid, vid, i+1, ?a);

* Handles nestings:
* internal leg (vid,i) becomes (the incoming end of) propagator m;
* the new sub-diagram gets propagator index m.
  id counter(n?) * diagram(pid?, vid?, i?, diagram(?b), ?a)
    = rf([f](vid,i), is[n]) * rp([p](vid,i), +ks[n]) 
      * counter(n+1) * diagram(n, ?b) * diagram(pid, vid, i+1, ?a);

* Removes completed (sub-) diagrams
  id diagram(pid?, vid?, i?) = 1;
  
*  #call print
  .sort
#enddo

id counter(n?) = 1;

.sort

id replace(vid?, i?, j?) = rp([p](vid,i), ps[j]) * rf([f](vid,i), as[j]);

argument rp, rf;
  #do VID=1,{`VERTID'-1}
    id [p](`VID',i?) = [ps`VID'][i];
    id [f](`VID',i?) = [fs`VID'][i];
  #enddo
endargument;

id rp(p?, q?) = replace_(p, q);
id rf(i?, j?) = replace_(i, j);

.sort

* Disconnects singlets
repeat id Tr(?a, 0) = Tr(?a);

* The loop makes it easier to find matching indices
* (just wildcards may fail)
* The maximum number of propagators is (NM-4)/2: 
* 0 for NM=4, 1 for NM=6, 2 for NM=8, etc.
#do I = 1,{{`NM'-4}/2}
  
* No need to worry about 1/Nf terms thanks to U(N) decoupling!
* (If we do need to worry, we handle it with singlet diagrams)
  id Tr(?a, i`I') * Tr(i`I', ?b) = Tr(?a, ?b);
  .sort
#enddo

id p?.p? = 0;

*#call print
*.end
.sort

#call cycl
#call permute(`NM')

*#call print
.sort:Finished diagram - ;

#endprocedure


