#procedure group(G, N)
* Multiplies the preceding expression by the function "group" containing
* Mandelstam variable substitutions (in the form of "replace" functions)
* representing all elements in a given group. The preceding expression should
* have a flavour structure that is invariant under the group, and should be
* expressed in a closed Mandelstam basis (prettymandel or split-trace closed
* basis).
*
* G should be the name of a group, written as [Zn1/n2/n3...], where ni are 
* integers representing the relevant flavour splitting. All cyclic groups are
* supported, but split-trace groups must be added manually. 
*
* The currently supported groups are:
*  - [ZN], a generic cyclic group. It will be interpreted as if [Z`N'] was 
*          written in accordance with the above rules. The procedure argument 
*          N can be any positive even number. For other groups, the argument
*          N is not used.
*  - [Z2/4], an order-8 abelian group.
*  - [Z3/3], an order-18 non-abelian group.
*  - [Z2/2/2], an order-48 non-abelian group.
*
* This procedure is provided in an "inline" fashion, so the preceding expression
* should not be terminated with a semicolon. 

* Multiplies by the group in terms of generators.
#if(`G' == [ZN])
  * group(1, <g1^1>,...,<g1^{`N'-1}>)
#elseif(`G' == [Z2/4])
  * group((1 + g1) * (1 + g2 + g2^2 + g2^3))
#elseif(`G' == [Z3/3])
  * group((1 + g2) * (1 + g1 + g1^2) * g2 * (1 + g1 + g1^2))
#elseif(`G' == [Z2/2/2])
  * group((1 + g2 + g2^2) * (1 + g3) * (1 + g1) * g2 * (1 + g1) * g2 * (1 + g1))
#else
  #message Error!
  #message Incorrect group name entered: `G'
  * 1/0
#endif
;

* Splits the sum of group elements into separate arguments.
splitarg group;

argument group;
*   Expands the generators in terms of Mandelstam variables. The ith argument
*   of replace should be what is substituted for the ith Mandelstam variable.
  #if(`G' == [ZN])
    id g1 = replace(<mandel[2]>,...,<mandel[{`N'}]>, mandel[1]
      #do I={`N'+1},{`N'*{`N'/2 - 2}},{`N'}
        , <mandel[{`I'+1}]>,...,<mandel[{`I'+`N'-1}]>, mandel[`I']
      #enddo
      , <mandel[{`N'*{`N'/2 - 2} + 2}]>,...,<mandel[{`N'*{`N'-3}/2}]>
      , mandel[{`N'*{`N'/2 - 2} + 1}]
    );
  #elseif(`G' == [Z2/4])
    id g1 = replace(t1,...,t6, -t7, -t8, -t9);
    id g2 = replace(t2,t3,t4,t1, t6,t5, t8, -t7, -t9);
  #elseif(`G' == [Z3/3])
    id g1 = replace(t1, 
                    w3*t3, w3*t4, w3*t2, 
                    w3^2*t6, w3^2*t7, w3^2*t5,
                    w3*t8, w3*t9);
    id g2 = replace(t1,
                    t3, t2, t4,
                    t6, t4, t7,
                    t9, t8);
  #elseif(`G' == [Z2/2/2])
    id g1 = replace(t1, t2, t6, t4, t5, t3,
                    -t7, -t8, t9);
    id g2 = replace(t2, t3, t1, t5, t6, t4,
                    t8, t9, t7);
    id g3 = replace(t1, t3, t2, t4, t6, t5,
                    t7, t9, t8);
  #endif
  
*  Expands the replace functions to have pairs of elements a, b such that
*  the substitution is a -> b. Then executes compositions of replacements
*  until only one remains.
  multiply left temp;
  repeat;
    id temp * replace(?a) = temp * replace(nargs_(?a), ?a);
    repeat id temp * replace(n?pos_, ?a, t1?) = temp * replace(n-1, 
      #if(`G' == [ZN])
        mandel[n],
      #else
        ts[n],
      #endif
    t1, ?a);
    id temp * replace(0,?a) * replace(?b) = temp(replace_(?a) * replace(?b));
    id temp(replace(?a)) = temp * replace(?a);
    id temp * replace(0, ?a) = replace(?a);

  endrepeat;

  id temp = 1;

*  Manages roots of unity. More should be added if needed.
  argument replace;
    id w3^3 = 1;
  endargument;

endargument;
  
#endprocedure
