:- initialization(start).
dynamic(state).
dynamic(is_ss).
dynamic(trans).


untrans(V,S1,S2) :-
	call(state(S1)),
	call(is_ss(V)),
	\+ trans(V,S1,S2).


gviz_attr(Option,Value) :-
	write(Option), write('="'),
	write(Value), write('"').

gviz_attrs([]) :- !.
gviz_attrs([[O,V],Attr|Attrs]) :- gviz_attr(O,V), write(','), gviz_attrs([Attr|Attrs]), !.
gviz_attrs([[O,V]|Attrs]) :- gviz_attr(O,V), gviz_attrs(Attrs).

gviz_header :-
	write('digraph G {'), nl,
	write('    undef [color="red"];'), nl.
gviz_footer :-
	write('}'), nl.
gviz_trans(V,S1,S2,Options) :-
	write('    '),
	write(S1),
	write(' -> '),
	write(S2),
	write(' ['),
	gviz_attrs([['label',V]|Options]),
	write('];'), nl.

render_trans(V,S1,S2) :- call(trans(V,S1,S2)), gviz_trans(V,S1,S2,[]).

render_untrans(V,S1,S2) :- untrans(V,S1,S2), gviz_trans(V,S1,undef,[['color','red']]).

start :-
	consult(user),
	write('---- GRAPH START ----'),nl,
	gviz_header,
	findall([V,S1,S2], render_trans(V,S1,S2),_),
	findall([V,S1,S2], render_untrans(V,S1,S2),_),
	gviz_footer.


