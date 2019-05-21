#procedure sfrule(NM, NP, SFR)
* Creates a stripped vertex Feynman rule.
* This is simply a version of sfruleid which
* automatically assigns new IDs to subsequent calls,
* beginning at 1. 
* A direct call to sfruleid jumps the ID counter
* so that subsequent calls to sfrule count up from the
* custom ID.

#call sfruleid(`NM',`NP',`SFR',`VERTID')

#endprocedure
