#procedure mandelHelper(NM, ARGPROP)
* Helper procedure to mandel.prc.
* 
* NM      - number of momenta
* ARGPROP - if 1, the procedure is applied to propagators;
*           if 0, it is applied to the rest of the amplitude. 

* Substitutes powers of momenta
#do I=1,`NM'

  #if(`ARGPROP')
    argument prop;
  #endif

*   The square of any momentum is zero in the massless case
  #if(`MASSIVE')
    id p`I'.p`I' = M2(`I');
  #else
    id p`I'.p`I' = 0;
  #endif

*   The product of adjacent momenta is simply half the corresponding
*   mandelstam variable (minus masses if included):
*   pi.p(i+1) = 1/2 * (s(pi,p(i+1)) - mi - m(i+1))
  id p`I'.p{`COFS(`I',1)'} 
    = 1/2 * (
        s(p`I',p{`COFS(`I',1)'})
        #if(`MASSIVE')
          - M2(`I') - M2({`COFS(`I',1)'})
        #endif
      );

  #if(`ARGPROP')
    endargument;
  #endif

  .sort

  #if(`ARGPROP')
    argument prop;
  #endif

*   The product of next-to-adjacent momenta requires the removal
*   of terms that do not contain both momenta (plus compensation for
*   removing p(i+1)^2 twice if masses are included):
*   pi.p(i+2) = 1/2 * (s(pi,p(i+2)) - s(pi,p(i+1)) - s(p(i+1),p(i+2)) 
*     + s(p(i+1),p(i+1))
  id p`I'.p{`COFS(`I',2)'} 
    = 1/2 * (
        s(p`I'            ,p{`COFS(`I',2)'})
      - s(p`I'            ,p{`COFS(`I',1)'})
      - s(p{`COFS(`I',1)'},p{`COFS(`I',2)'})
      #if(`MASSIVE')
        + M2({`COFS(`I',1)'})
      #endif
      );

  #if(`ARGPROP')
    endargument;
  #endif

  .sort

*   The same goes for larger separations, except that we need to
*   add the terms that contain neither momentum since we removed
*   them twice:
*   pi.pj = 1/2 * (s(pi,pj) - s(pi,p(j-1)) - s(p(i+1),pj) + s(p(i+1),p(j-1))
  #if(`NM' > 4)
    #do J=3,{`NM'/2}

      #if(`ARGPROP')
        argument prop;
      #endif

      id p`I'.p{`COFS(`I',`J')'} 
         = 1/2 * (
            s(p`I',            p{`COFS(`I',`J')'})
          - s(p`I',            p{`COFS(`I',{`J'-1})'})
          - s(p{`COFS(`I',1)'},p{`COFS(`I',`J')'})
          + s(p{`COFS(`I',1)'},p{`COFS(`I',{`J'-1})'})
          );

      #if(`ARGPROP')
        endargument;
      #endif

      .sort

    #enddo

  #endif

#enddo

#if(`ARGPROP')
  argument prop;
#endif

* In the previous step, we went a bit to far and introduced the next set
* of variables (e.g. s(p1,p5) for NM=8). We use conservation of momentum
* to remove them (e.g. s(p1,p5) = s(p6,p8) for NM=8).
* For NM=4, we get further simplification, e.g. s(p1,p3) = s(p4,p4),
* which is zero in the massless case.
#do I=1,`NM'
  id s(p`I',p{`COFS(`I',{`NM'/2})'})
  #if(`NM' > 4)
    = s(p{`COFS(`I',{`NM'/2 + 1})'},p{`COFS(`I',{`NM' - 1})'});
  #elseif(`MASSIVE')
    = M2({`COFS(`I',3)'});
  #else
    = 0;
  #endif
#enddo

#if(`ARGPROP')
  endargument;
#endif

.sort

#if(`ARGPROP')
  argument prop;
#endif

* Lastly, remove half of the last kind of variable, keeping the ones
* whose first index is smallest (e.g. s(p6,p1) -> s(p2,p5) for NM=8).
#do I={`NM'/2 + 1},{`NM'}
  id s(p`I',p{`COFS(`I',{`NM'/2 - 1})'}) 
    = s(p{`COFS(`I',{`NM'/2})'},p{`COFS(`I',{`NM'-1})'});
#enddo

#if(`ARGPROP')
  endargument;
#endif

.sort

#endprocedure
