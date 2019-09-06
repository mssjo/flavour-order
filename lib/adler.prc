#procedure adler(NM, Z)
* Implements an adler zero by setting pZ to zero.
* NM is the total number of momenta. This procedure only works in
* Mandelstam variables, so mandel(NM) (but not prettymandel) must be
* called beforehand.

#call adlerHelper(`NM',`Z')
argument prop;
#call adlerHelper(`NM',`Z')
endargument;

.sort

id s(?a) * prop(s(?a)) = 1;
id i? * prop(i?) = 1;

** Calls prettymandel for readability
** so that we can see what is left if ADLER=0
** or if something went wrong
*#call prettymandel(`NM')

.sort

#endprocedure
