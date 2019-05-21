#procedure mandelrand(NM,PRETTY)

.sort

#if(`PRETTY')

  #if(`MASSIVE')
    #define NMANDEL "{1 + {`NM'-2}*{`NM'/2}}"
  #else
    #define NMANDEL "{{`NM'}*{`NM'/2 - 1}}"
  #endif

  table zerofill rand(1:`NMANDEL');
  #do I=1,`NMANDEL'
    fill rand(`I') = 
      `I'*(1-`I');
  #enddo

  .sort

  #do I=1,`NMANDEL'
    multiply replace_(mandel[`I'], rand(`I'));
  #enddo
  
#else

table zerofill rand(1:`NM',1:`NM');

#do I=1,`NM'
  #do J=0,{`NM'/2 - 1}
    fill rand(`I', {`COFS(`I',`J')'}) 
*      = 11*`I' + 13*`J';
       = 3*`I' + 5*`J';
*       = `I'+`J';
*      = `I';
*      = 1;
  #enddo
#enddo

id s(p?ps[m], q?ps[n]) = rand(m,n);
argument prop;
  id s(p?ps[m], q?ps[n]) = rand(m,n);
endargument;

#endif

.sort

id prop(i?) = 1/i;

#endprocedure
