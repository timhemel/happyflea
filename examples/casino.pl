% all defined DFA states
state(start).
state(play).
state(score).

% possible values for statespace operation
oper(bet).
oper(hit).
oper(stay).
oper(play_again).

% possible values for statespace count
cnt(lt21).
cnt(eq21).
cnt(gt21).


% define properties on statespace
operation(ss(Op,_),Op) :- oper(Op).
count(ss(_,Count),Count) :- cnt(Count).

% statespace must have operation and count properties
is_ss(V) :- operation(V,_), count(V,_).

% DFA transitions
trans(V,start,play) :- operation(V,bet).
trans(V,play,play) :- operation(V,hit), count(V,lt21).
trans(V,play,score) :- operation(V,hit), count(V,eq21).
trans(V,play,score) :- operation(V,hit), count(V,gt21).
trans(V,play,score) :- operation(V,stay).
trans(V,score,start) :- operation(V,play_again).

