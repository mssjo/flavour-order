#procedure mandel(NM);

* This procedure expresses products of momenta in terms of
* generalised Mandelstam variables.
* The momenta are assumed to be named p1,p2,...
* NM is the number of momenta involved; in the examples below,
* a value of 8 is used.
* The mandelstam variables are expressed with a function S, where
*  s(p1,p1) = (p1)^2
*  s(p1,p2) = (p1 + p2)^2
*  s(p1,p3) = (p1 + p2 + p3)^2
*  s(p1,p4) = (p1 + p2 + p3 + p4)^2
* (and so on for higher NM) plus cyclic permutations thereof:
*  s(p1,p2), s(p2,p3),..., s(p7,p8), s(p8,p1) etc.
* Due to conservation of momentum, we have
*  s(pi, pj) = s(p(j+1), p(i-1)).
* Therefore, we do not need variables with more than NM/2 momenta, and
* we only need to use half of those with exactly NM/2 momenta. We choose
* to keep exactly those that include p1.

* Lots of sorts upcoming, so turning statistics off spares your screen & eyes
.sort
off statistics;

* Most of the work (and documentation) is in here
#call mandelHelper(`NM', 0)

* Rewrites the propagators in terms of Mandelstam as well
id prop(?a) = prop(q, ?a);
repeat id prop(q?, p?, ?a) = prop(q+p, ?a);
#if(`MASSIVE'=0)
  id prop(p?) = prop(p.p);
#elseif(`MASSIVE'=1)
  id prop(p?) = prop(p.p - Mpi^2);
#elseif(`MASSIVE'=2)
  id prop(p?,m?) = prop(p.p - m^2);
#endif

argument prop;
  id q = 0;
endargument;
id prop(0,pp?) = prop(pp);
#call mandelHelper(`NM', 1)

.sort
on statistics;

* A propagator is now just the inverse of its argument
id s(?a) * prop(s(?a)) = 1;

.sort

#redefine MANDEL "1"

#endprocedure
