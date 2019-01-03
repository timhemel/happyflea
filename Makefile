
GPLC=gplc

happyflea_main: happyflea_main.pl
	$(GPLC) --no-top-level --no-debugger $<

