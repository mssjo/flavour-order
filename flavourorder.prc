#procedure flavourorder(NM, VERT, VID)
* Takes a "raw" vertex (a product of traces of Lorentz-index-equipped fields M)
* called VERT and turns it into a flavour-ordered vertex factor (a product of
* traces of generators, with indices [f.VID.IDX] in ascending order and traces 
* split in accordance with SPLIT, mutliplied by scalar products of the 
* corresponding momenta [p.VID.IDX]).
*
* The splitting works as follows: if SPLIT is set to split(n1, n2, ..., nk),
* the only terms that are kept will contain n1 flavour indices in the first trace
* (specifically, a1 through a(n1)), n2 indices in the second one (a(n1+1)
* through a(n1+n2)), etc. It is the responsibility of the user to ensure that
* the n's add up to NM.
* The symbol "nosplit" is equivalent to split(NM), i.e. only a single trace
* containing all the flavour indices.
* The symbol "anysplit" circumvents the splitting process; all terms are kept.
*
* The effect of this procedure is similar to the old sequence
*   setflavourindex -> setmomentum -> takederiv -> pickout (looped) -> split
* but is vastly more efficient since it flavour-orderes everything from the
* beginning rather than generating all permutations and then removing
* the unordered ones.

.sort
skip;
nskip `VERT';

* Generates all permutations of traces. They are not many,
* so brute force is simple and appropriate.
multiply left perm();
repeat id perm(?a) * Tr(?b) = perm(?a, tr(?b));
id perm(?a) = perm_(perm, ?a);
repeat id perm(?a, tr(?b)) = perm(?a) * tr(?b);
id perm() = 1;

#call print
.sort:Permuting traces -;
skip;
nskip `VERT';

multiply left `SPLIT';

id unsplit = split(`NM');

* This part ensures that we only keep terms on the form 
*   tr(n1 M's) * tr(n2 M's) * ...
* when SPLIT = split(n1,n2,...).
* If SPLIT = anysplit, not much happens.
id tr(?a) = tr(?a, nargs_(?a));  
repeat;
  id split(i?, ?a) * tr(?b, i?) = tr(?b) * split(?a);
  id anysplit()    * tr(?b, i?) = tr(?b) * anysplit();
endrepeat;
id split() = 1;
id anysplit() = 1;
id split(?a, i?) = 0;

#call print
.sort:Splitting traces -;
skip;
nskip `VERT';

* This part splits fields M into generator-field products t(a)*phi(a),
* with the indices in ascending order.
* The phi's, being scalar, are ejected from the traces.
* At the same time, cyclings are set up by counting the indices.
multiply left cycle(0);
#do I=1,`NM'
  id cycle(i?, ?a) * tr(M(?l), ?b) 
    = cycle(i+1, ?a, `I') * tr(?b, [f`VID'.`I']) * phi(?l, [p`VID'.`I']);
  id tr(a?[fs`VID'], ?b) = Tr(a, ?b) * cycle(0);
#enddo

* Acts with derivatives to bring out momenta. 
* After this, the phi's are of no more use, and are discarded.
repeat id phi(mu?, ?l, p?) = i_ * p(mu) * phi(?l, p);
id phi(p?) = 1;

#call print
.sort:Handling fields -;
skip;
nskip `VERT';

* Executes the cyclings. This is identical to cycl.prc, but adapted 
* to the vertex-ID format.
id cycle(0) = 1;
id cycle(n?, ?a) = cycle(n, ?a) * replace(?a) * rp();
  
repeat id cycle(n?{>1}, ?a, i?) = cycle(1, ?a, i) + cycle(n-1, i, ?a);
id cycle(1, ?a) = cycle(?a);

repeat id cycle(i?, ?a) * replace(j?, ?b) * rp(?c) 
  = cycle(?a) * replace(?b) * rp(?c, [ps`VID'][j], [ps`VID'][i]);

id cycle() = 1;
id replace() = 1;
id rp(?a) = replace_(?a);
id rf(?a) = replace_(?a);

#call print
.sort:Executing cyclings -;

#endprocedure
