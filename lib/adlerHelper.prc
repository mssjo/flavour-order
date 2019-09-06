#procedure adlerHelper(NM, Z)
* Auxiliary to adler.prc

#if(`ADLER'>0)

  #if(`PRETTYMANDEL')
  
    #if(`NM'>4)
  
*       e.g. s12 -> 0, s61 -> 0 when Z=1
      id s`Z'{`COFS(`Z',1)'} = 0;
      id s{`COFS(`Z',{`NM'-1})'}`Z' = 0;

      #do I=2,{`NM'/2-1}
*       e.g. s13 -> s23, s51 -> s56 when Z=1
        id  s`Z'{`COFS(`Z',`I')'} 
          = s{`COFS(`Z',1)'}{`COFS(`Z',`I')'};
        id  s{`COFS(`Z',{`NM'-`I'})'}`Z'  
          = s{`COFS(`Z',{`NM'-`I'})'}{`COFS(`Z',{`NM'-1})'};
      #enddo

*     When Z is not 1, some variables that do not contain Z should
*     still be removed by conservation of momentum.
*     This ensures that they are taken care of as well.
*     (e.g. s51 = s24 -> s23, s13 = s46 -> s56  when Z=4 and NM=6)
      id  s{`COFS(`Z',1)'}{`COFS(`Z',`NM'/2)'}
        = s{`COFS(`Z',{`NM'/2 + 1})'}{`COFS(`Z',{`NM' - 1})'};
      id  s{`COFS(`Z',{`NM'/2})'}{`COFS(`Z',{`NM' - 1})'}
        = s{`COFS(`Z',1)'}{`COFS(`Z',{`NM'/2 - 1})'};

    #else
      id [s] = 0;
      id [u] = 0;
    #endif

  #else

*   e.g. s12 -> 0, s61 -> 0 when Z=1
    id s(p`Z', p{`COFS(`Z',1)'}) = 0;
    id s(p{`COFS(`Z',{`NM'-1})'}, p`Z') = 0;

    #do I=2,{`NM'/2-1}
*     e.g. s13 -> s23, s51 -> s56 when Z=1
      id  s(p`Z', p{`COFS(`Z',`I')'}) 
        = s(p{`COFS(`Z',1)'},p{`COFS(`Z',`I')'});
      id  s(p{`COFS(`Z',{`NM'-`I'})'}, p`Z')  
        = s(p{`COFS(`Z',{`NM'-`I'})'}, p{`COFS(`Z',{`NM'-1})'});
    #enddo

*   When Z is not 1, some variables that do not contain Z should
*   still be removed by conservation of momentum.
*   This ensures that they are taken care of as well.
*   (e.g. s51 = s24 -> s23, s13 = s46 -> s56  when Z=4 and NM=6)
    id  s(p{`COFS(`Z',1)'}, p{`COFS(`Z',`NM'/2)'}) 
      = s(p{`COFS(`Z',{`NM'/2 + 1})'}, p{`COFS(`Z',{`NM' - 1})'});
    id  s(p{`COFS(`Z',{`NM'/2})'}, p{`COFS(`Z',{`NM' - 1})'}) 
      = s(p{`COFS(`Z',1)'}, p{`COFS(`Z',{`NM'/2 - 1})'});

  #endif

#endif

#endprocedure
