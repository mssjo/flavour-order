#procedure permute(NM)
* Before calling this method, the relevant diagrams should be multiplied
* by perm(...), where the arguments are some permutation of 1,...,NM.
* This procedure executes all such permutations, so for instance,
*  (p1.p3 + p2.p4) * permute(1,3,2,4) 
* is turned into
*  (p1.p2 + p3.p4)
* by calling permute(4). Weird results will be produced if NM does not match the
* number of arguments to perm(...), or if they are not a permutation of 1,...,NM. 

* Flavour/momentum I is replaced by flavour/momentum i, where i is the Ith
* argument to perm
#do I=1,`NM'
  id permute(i?, ?a) = permute(?a, `I', i);
#enddo

id permute(<i1?>,...,<i{`NM'*2}?>) = 
    replace_(<ps[i1]>,...,<ps[i{`NM'*2}]>) 
  * replace_(<as[i1]>,...,<as[i{`NM'*2}]>);

.sort

#endprocedure
