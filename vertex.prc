#procedure vertex(NM, NP, PAR, VERT)
* Calculates a vertex factor and places it in an
* expression named VERT.
* - NM is the number of fields in the vertex
* - NP is the number of derivatives on the vertex
* - PAR is the parametrisation to be used:
* -- EXP exponential parametrisation
* -- CAY Cayley parametrisation
* -- MIN minimal parametrisation
* -- BIJ Bijnens parametrisation (kills O(p²) mass interaction terms)

#message Parametrisation:  `PAR'

* Implements the NLSM Lagrangian to LO, NLO, and NNLO
* The field u_mu is represented as u(mu); additional indices 
* represent covariant derivatives.
* (rho is written ro for brevity, not because of ignorance)
global `VERT' =
#if(`NP' = 2)
    F^2/4*(
      tr(u(mu),u(mu)) 
      #if(`MASSIVE')
        + tr(chip)
      #endif
    )
  ;
#elseif(`NP' = 4)
  #if(`NF'>2)
    L1*tr(u(mu),u(mu))*tr(u(nu),u(nu))
  #endif
  #if(`NF'>3)
  + L2*tr(u(mu),u(nu))*tr(u(mu),u(nu))
  #endif
  + L3*tr(u(mu),u(mu),u(nu),u(nu))
  + L0*tr(u(mu),u(nu),u(mu),u(nu))
  
  #if(`MASSIVE')
* The LECs are originally defined in the U,chi basis, hence the weird
* combinations of L8 and H2. The H2 term does not contain any U's, and
* should therefore vanish in all vertices.
  #if(`NF'>2)
    + L4*tr(chip)*tr(u(mu),u(mu))
  #endif
    + L5*tr(chip,u(mu),u(mu))
    + L6*tr(chip)*tr(chip)
    + L7*tr(chim)*tr(chim)
    + L8*(tr(chip,chip) + tr(chim,chim))/2
*   + H2*(tr(chip,chip) - tr(chim,chim))/2
  #endif
  ;
#elseif(`NP' = 6)
* Taken from the version produced in tandem with the O(p⁸) Lagrangian
* of Bijnens, Hermansson-Truedsson & Wang, 2018
* (the O(p⁶) Lagrangian is unpublished, but supersedes the overcomplete 
*  version by Bijnens, Colangelo & Ecker, 1999)
    C1  * tr(u(mu),u(nu,ro))*tr(u(mu),u(ro,nu))
  + C2  * tr(u(mu),u(nu,ro))*tr(u(ro),u(nu,mu))

  + C3  *(tr(u(mu),u(nu,mu),u(ro),u(nu,ro))  
         +tr(u(mu),u(nu,ro),u(ro),u(nu,mu)))
  + C4  * tr(u(mu),u(nu,ro),u(mu),u(ro,nu))

* Only loads these terms if vertex will require them
  #if(`NM' >= 6)
  + C5  * tr(u(mu),u(mu))*tr(u(nu),u(nu))*tr(u(ro),u(ro))
  + C6  * tr(u(mu),u(mu))*tr(u(nu),u(ro))*tr(u(nu),u(ro))
  + C7  * tr(u(mu),u(nu))*tr(u(mu),u(ro))*tr(u(nu),u(ro))

  + C8  * tr(u(mu),u(mu))*tr(u(nu),u(nu),u(ro),u(ro))
  + C9  * tr(u(mu),u(mu))*tr(u(nu),u(ro),u(nu),u(ro))
  + C11 * tr(u(mu),u(nu))*tr(u(mu),u(nu),u(ro),u(ro))
  + C12 * tr(u(mu),u(nu))*tr(u(mu),u(ro),u(nu),u(ro))

  + C10 * tr(u(mu),u(mu),u(nu))*tr(u(nu),u(ro),u(ro))
  + C13 * tr(u(mu),u(nu),u(ro))*tr(u(mu),u(nu),u(ro))
  + C14 * tr(u(mu),u(nu),u(ro))*tr(u(mu),u(ro),u(nu))

  + C15 * tr(u(mu),u(mu),u(nu),u(nu),u(ro),u(ro))
  + C16 * tr(u(mu),u(mu),u(nu),u(ro),u(nu),u(ro))
  + C17 * tr(u(mu),u(mu),u(nu),u(ro),u(ro),u(nu))
  + C18 * tr(u(mu),u(nu),u(mu),u(ro),u(nu),u(ro))
  + C19 * tr(u(mu),u(nu),u(ro),u(mu),u(nu),u(ro))
  #endif
  ;
#elseif(`NP' = 8)
* Taken from Bijnens, Hermansson-Truedsson & Wang, 2019
* Moved to a separate file due to its size.
  #include p8lagr.hf
  ;
#else
  1/0;
  #message Unsupported order!    
  .end
#endif

.sort;
skip;
nskip `VERT';

multiply i_;

* Places fields outside traces
* so that distributive addition can do its thing.
repeat id tr(?a, bb?cbb(?l)) = tr(?a) * bb(?l);

* Writes out fields in terms of their definitions.
* Up until this point, u(mu) is a separate entity from u.
* Here, we rewrite it so that u(mu) is just the mu-derivative of u.
* TODO in the future: general treatment of covariant derivatives!
id u(mu?) = i_  * (u(dag)*u(mu) - u*u(dag,mu));
id u(mu?, nu?) = i_ * (
                         u(dag,mu)*u(nu) + u(dag)*u(mu,nu) 
                       - u(mu)*u(dag,nu) - u*u(dag, mu,nu) 
                       + Gamma(mu) * (u(dag)*u(nu) - u*u(dag,nu))
                       - (u(dag)*u(nu) - u*u(dag,nu))* Gamma(mu)
                       );
id Gamma(mu?) = 1/2 * (u(dag)*u(mu) + u*u(dag,mu));

id chip = u(dag)*chi*u(dag) + u*chi(dag)*u;
id chim = u(dag)*chi*u(dag) - u*chi(dag)*u;

.sort
*#call print
*.end

* In the following, we will expand the Lagrangian into all terms that
* contain exactly NM instances of M, without first expanding every
* u, u(dag) to that order and discarding unwanted terms, a process which
* is very wasteful.


* Equips all chiral building blocks with a power counter
id bb?cbb(?a) = bb(?a, 0);

* Joins all traces for easier handling, but marks where the splits were.
repeat id tr(?a) * bb?cbb(?b) = tr(?a, bb(?b));
id tr(bb?cbb(?a), ?b) = tr(bb(split, ?a), ?b);
repeat id tr(?a) * tr(?b) = tr(?a, ?b);

* Equips the joined trace with a counter for the desired number of fields.
id tr(?a) = tr(`NM', ?a);

* Ensures that all u's with derivatives are expanded to at least 1st order.
repeat id tr(i?pos0_, ?a, u(?l, mu?lz, 0), ?b)
    = tr(i-1, ?a, u(?l, mu, -1), ?b);
* There wasn't enough powers to do that - term vanishes!
id tr(i?neg_, ?a) = 0;
* u(?l, i) is expanded to order i+(1 if derivative, 0 otherwise);
* shifting the zero simplifies things below.
* -1 was just a marker that the derivatives had "eaten" enough orders.
argument tr;
  id u(?l, -1) = u(?l, 0);
endargument;

.sort
*#call print
*.end

* Recursively enumerates all combinations of powers that sum to NM
* e.g. u(2)*u(0) + u(1)*u(1) + u(0)*u(2) for NM=2
id tr(i?, bb?cbb(?l, j?pos0_), ?a) = tr(bb(?l, j+i), ?a);
repeat;
  id tr(u(?l, i?pos_), bb?cbb(?ll, j?int_), ?a)
    = tr(u(?l, i-1), bb(?ll, j+1), ?a)
      + u(?l, i) * tr(bb(?ll, j), ?a);

  id tr(u(?l, 0), ?b) = u(?l, 0) * tr(?b);
  id tr(chi(?l, i?int_), bb?cbb(?ll, j?int_), ?a) 
    = chi(?l, 0) * tr(bb(?ll, i+j), ?a);
endrepeat;
id tr(bb?cbb(?a)) = bb(?a);
id tr() = 1;

* Shifts the zeroes back
id u(?l, mu?lz, i?int_) = u(?l, mu, i+1);

*#call print
*.end

* Reinstates the traces
id bb?cbb(split, ?a) = tr() * bb(?a);

* Expands to exactly the right power.
* Notation: M(mu, nu, ..., i) = d_mu( d_nu ( ... ( M^i) ... ))
id u(dag, ?l, i?int_) = (-i_*invsqrt2/F)^i * M(?l, i) * param(i);
id u(     ?l, i?int_) = ( i_*invsqrt2/F)^i * M(?l, i) * param(i);
id chi(   ?l, i?pos_) = 0;
id chi(   ?l, 0     ) = chi(?l);

** This is the old, slow way - becomes awful at O(p^6)!
*id U(?l)    = sum_(i, 0, `NM', ( i_*sqrt2/F)^i*M(?l, i)*param(i));
*id Udag(?l) = sum_(i, 0, `NM', (-i_*sqrt2/F)^i*M(?l, i)*param(i));
*id M(mu?, ?l, 0) = 0;
*if(count(F,-1) != `NM') 
*  discard;

id param(0) = 1;
id param(1) = 1;
#if(`PAR' == EXP)
** Exponential parametrisation
  id param(i?) = invfac_(i);
#elseif(`PAR' == CAY)
** Cayley parametrisation
  id param(i?) = 1/(2^(i-1));
#elseif(`PAR' == MIN)
** Minimal parametrisation
  id param(i?odd_) = 0;
  id param(i?even_) = sign_(1 + i/2)/(2^(i-2)) * binom_(i-2,i/2 - 1)/i;
#elseif(`PAR' == BIJ)
** Bijnens parametrisation
  id param(2) = 1/2;
  id param(3) = 1/8;

  id param(i?even_) = 0;
  id param(i?odd_) = param((i-1)/2);

  id param(i?even_) = -fac_(i-2)/(2^(7*i/2 - 1) * fac_(i/2-1));
  id param(i?odd_) = fac_((i+1)/2 - 2)/(2^(5*(i+1)/2 - 1));
#else
  id param(i?) = 1/0;
  #message Unsupported parametrisation!
  .end
#endif

*id sqrt2^2 = 2;
id invsqrt2^2 = 1/2;

*#call print
*.end
.sort
skip;
nskip `VERT';

id chi(dag) = chi;

* Puts stuff inside traces
repeat id tr(?a)*M?fsm(?b) = tr(?a,M(?b));

id tr(?a) = Tr(?a);

*#call print
*.end
.sort
off statistics;
skip;
nskip `VERT';

* Expands derivatives of M
* Repeatedly swaps between tr (easier to handle) 
* and Tr (allows simplification by cyclicity)
#do i=1, {`NM'+`NP'}
  id Tr(?a) = tr(?a);
  id tr(?a, M(?l, 1), ?b) = tr(?a, M(?l), ?b);
  id tr(?a, M(mu?, j?{>1}), ?b) = tr(?a, M(mu), M(j-1), ?b)
                                + tr(?a, M, M(mu, j-1), ?b);
* Only second derivatives for now - need different treatment for generality
  id tr(?a, M(mu?, nu?, j?{>1}), ?b)
                                = tr(?a, M(mu, nu), M(j-1), ?b)
                                + tr(?a, M(mu), M(nu, j-1), ?b)
                                + tr(?a, M(nu), M(mu, j-1), ?b)
                                + tr(?a, M, M(mu, nu, j-1), ?b);
  id tr(?a, M(i?pos_), ?b) = tr(?a, M, M(i-1), ?b);
  id tr(?a, M(0), ?b) = tr(?a, ?b);
  id tr(?a) = Tr(?a);
  .sort
  skip;
  nskip `VERT';
#enddo

*#call print
*.end
.sort
on statistics;
skip;
nskip `VERT';

#message O(p^`NP') `NM'-point vertex factor:
#call print
.sort

#endprocedure

