#procedure prettymandel(NM)
* Converts the flexible function-based Mandelstam variables
* (e.g. s(p1,p2)) to less flexible but more readable
* symbol-based variables (e.g. s12). Also introduces s,t,u
* for 4-point scattering.

.sort

#if(`MASSIVE')
  symbol  m1,...,m{`NM'};
  set ms: m1,...,m{`NM'};

  #do I=1,`NM'
    id M2(`I') = m`I';
    argument;
      id M2(`I') = m`I';
    endargument;
  #enddo
  .sort
#endif

#if(`NM' = 4)
* The symbols for the ordinary Mandelstam variables s, u (and t) 
* are already defined, so we'll have to settle with formal names
  symbol [s],[u],[t];
  set mandel:
  #if(`MASSIVE')
    m1,...,m{`NM'}
  #endif
  , [s], [u];

  id s(p1,p2) = [s];
  id s(p2,p3) = [u];

#else

  symbol
  #do J=1,{`NM'/2-1}
    #do I=1,`NM'
      , s`I'{`COFS(`I',`J')'}
    #enddo
  #enddo
  ;
  set mandel:
  #if(`MASSIVE')
    m1,...,m{`NM'}
  #endif
  #do J=1,{`NM'/2-1}
    #do I=1,`NM'
      , s`I'{`COFS(`I',`J')'}
    #enddo
  #enddo
  ;

  #do I=1,`NM'
    #do J=1,{`NM'/2 - 1}
      id s(p`I',p{`COFS(`I',`J')'}) = s`I'{`COFS(`I',`J')'};
      argument;
        id s(p`I',p{`COFS(`I',`J')'}) = s`I'{`COFS(`I',`J')'};
      endargument;
    #enddo
  #enddo

#endif

.sort

#redefine PRETTYMANDEL "1"

#endprocedure
