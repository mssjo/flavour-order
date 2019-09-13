
#prependpath ../lib/

#define NM "8"
#define OP "4"

#include defs.hf
#include init_fo.hf

#call fodge(M`NM'p`OP', `NM')

#call adler(`NM', 1);
#call mandelrand(`NM', 0);

#call print
.end
