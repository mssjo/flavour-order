#include defs.hf

load save/M8p2a`PAR'.sav;
load save/M8p2b`PAR'.sav;
load save/M8p2c`PAR'.sav;

local M8p2a = M8p2a`PAR';
local M8p2b = M8p2b`PAR';
local M8p2c = M8p2c`PAR';

.sort
skip;
nskip M8p2a;

multiply replace_(<ext1,a1>,...,<ext8,a8>);
multiply replace_(<p1ext,p1>,...,<p8ext,p8>);

.sort
skip;
nskip M8p2b;

multiply right v1(1,...,8);
id v1(?a) = distrib_(1,3,v1,v2,?a);
id v1(?a)*v2(?b) = f(?a,?b);
#call replace(8);

.sort
skip;
nskip M8p2c;

multiply right v1(1,...,8)/2;
id v1(?a) = distrib_(1,3,v1,v2,?a);
id v2(?a) = distrib_(1,2,v2,v1,?a);
id v1(?a)*v2(?b)*v1(?c) = f(?a,?b,?c);
#call replace(8);

.sort

*Strips the amplitude
#call strip(8,2)

.sort
drop;
global M8p2 = M8p2a + M8p2b + M8p2c;

.store
save save/M8p2.sav M8p2;

.end


