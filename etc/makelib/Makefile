Makefiles= 	./Makefile ./makefile ./MAKEFILE
Makefiles= 	./Makefile
GREP=		grep -s

targets:
	-@$(GREP) '^[^	#][^=:]*:[ 	]' $(Makefiles)

macros:
	-$(GREP) '^[^#].*=' $(Makefiles)
