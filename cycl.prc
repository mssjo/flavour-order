#procedure cycl
* Executes all cyclic premutations. Before calling this procedure,
* all relevant diagrams should be multiplied by 
*  cycle(n, i,...)
* where i,... are the indices that are to be cycled, and
* n is the number of steps to be made (typically 1 or 1/2 times the
* number of i's).
* The momenta are taken to use the symbol p and to live in the set ps.
* It is assumed that the cyclings line up with the traces, so the
* flavours are not touched. However, if masses are included,
* the extra generators need to be moved around, so the flavours are cycled.

id cycle(n?, ?a) = cycle(n, ?a) * replace(?a) * rp();

repeat id cycle(n?{>1}, ?a, i?) = cycle(1, ?a, i) + cycle(n-1, i, ?a);
id cycle(1, ?a) = cycle(?a);

repeat id cycle(i?, ?a) * replace(j?, ?b) * rp(?c)   
  = cycle(?a) * replace(?b) * rp(?c, ps[j], ps[i]);

id cycle() = 1;
id replace() = 1;
id rp(?a) = replace_(?a);
id rf(?a) = replace_(?a);


.sort:Cycling -;

#endprocedure
