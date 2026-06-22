Makefiles= 	./Makefile
GREP=		egrep -s

targets:
	-@$(GREP) '^([^	#][^=:]*:|[^	#][^=:]*:[^=]*)$$' $(Makefiles)

macros:
	$(GREP) '^[^#].*=' $(Makefiles)
