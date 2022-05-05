#UFL PARAM
param n integer; #facility
param m integer; #clients

set I := {1..n}; #facility
set J := {1..m}; #clients

param b {I} integer; #IGNORE
param f {I} integer; #COST ACT
param d {J} integer; #IGNORE
param c {I, J} integer; #COST ASSIGN = fac * client

#DUAL ASC PARAM
param bound;
param z{J};	#ESTIMATED BOUND VECT
param zaux{I};	#AUX VARIABLE

#UFL PROBLEM FORMULATION
var y {I, J} binary; #SERVIZIO FABRICA/UTENTE
var x {I} binary; #ATTIVAZIONE FABBRICA

minimize total_cost: 
	sum {i in I, j in J} (c[i, j] * y[i, j])
	+ sum {i in I} (x[i] * f[i]);
s.t. SERVIZIO{j in J}  :
	sum {i in I} y[i, j] >= 1;
s.t. ATTIVAZIONE {i in I, j in J}:
	x[i] - y[i, j] >= 0;

#COMPARING BOUND AND OPT SOL
param diff integer;	#LOWER IS BETTER		