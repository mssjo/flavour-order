#include defs.hf

load save/M8p4a`PAR'.sav;
load save/M8p4b`PAR'.sav;
load save/M8p4c`PAR'.sav;
load save/M8p4d`PAR'.sav;
load save/M8p4e`PAR'.sav;

local M8p4a = M8p4a`PAR';
local M8p4b = M8p4b`PAR';
local M8p4c = M8p4c`PAR';
local M8p4d = M8p4a`PAR';
local M8p4e = M8p4b`PAR';

.sort
skip;
nskip M8p4a;

multiply replace_(<ext1,a1>,...,<ext8,a8>);
multiply replace_(<p1ext,p1>,...,<p8ext,p8>);

.sort
skip;
nskip M8p4b, M8p4c;

multiply right v1(1,...,8);
id v1(?a) = distrib_(1,3,v1,v2,?a);
id v1(?a)*v2(?b) = f(?a,?b);
#call replace(8);

.sort
skip;
nskip M8p4d;

multiply right v1(1,...,8)/2;
id v1(?a) = distrib_(1,3,v1,v2,?a);
id v2(?a) = distrib_(1,2,v2,v1,?a);
id v1(?a)*v2(?b)*v1(?c) = f(?a,?b,?c);
#call replace(8);

.sort
skip;
nskip M8p4e;

multiply right v1(1,...,8);
id v1(?a) = distrib_(1,3,v1,v2,?a);
id v2(?a) = distrib_(1,2,v2,v3,?a);
id v1(?a)*v2(?b)*v3(?c) = f(?a,?b,?c);
#call replace(8);

.sort

#call strip(8,4)

.sort
drop;
global M8p4 = M8p4a + M8p4b + M8p4c + M8p4d + M8p4e;

.store
save save/M8p4.sav M8p4;

.end


