#procedure uncycle
* This procedure undoes cyclings. It acts on amplitudes expressed in terms of
* a closed mandelstam basis (prettymandel or a split-trace closed basis).
* Before calling this method, the terms must be multiplied by a call to
* group.prc, using the appropriate group for the flavour structure.
* This procedure will remove the group factor and reduce the kinematic terms
* to their uncycled form.

* The term is swallowed into an "uncycle" function.
multiply left uncycle(1);
repeat;
  id uncycle(pp?) * s12?mandel = uncycle(pp * s12);
  id uncycle(pp?) * t1?ts      = uncycle(pp * t1 );
  id uncycle(pp?) * prop(?a)   = uncycle(pp * prop(?a));
endrepeat;

*#call print
*.end

* The left copy is the current version, the right one is the next.
* The temp is used to reset the right copy to the identity permutation.
id uncycle(pp?) = temp(pp) * uncycle(pp) * uncycle(pp);

* Compensates for the length of the orbits.
id group(?a) = group(?a) / nargs_(?a);

* Ignores the identity.
id group(?a, 1, ?b) = group(?a, ?b);

*#call print
*.end

* Repeats until all representatives are found.
repeat;

*  Applies the next group element...
  id uncycle(pp?) * group(replace(?a), ?b) 
    = uncycle(pp * replace_(?a)) * group(?b);
  argument uncycle;
    id w3^3 = 1;
  endargument;

*   If the new version is "less" than the current one, we replace it!
  id disorder uncycle(?a) * uncycle(?b) = uncycle(?b) * uncycle(?b);

*   Breaks when all group elements have been tried.
  id ifmatch->break group() = 1;

*   Resets in preparation for the next group element.
  id temp(?a) * uncycle(?b) * uncycle(?c) = temp(?a) * uncycle(?b) * uncycle(?a);

endrepeat;
label break;
* At this point, all orbits have been reduced to a representative. 

*#call print
*.end

* Extracts the representative.
id temp(?a) * uncycle(pp?) * uncycle(qq?) = pp;

.sort:Uncycling - ;
#message Expressions have been uncycled.
#message Note: all expressions below are implicitly "+ cycl."
#message (with cycl representing the appropriate group)

#endprocedure
