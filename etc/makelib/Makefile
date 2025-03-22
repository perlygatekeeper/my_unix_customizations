.SUFFIXES: .png .webp
Makefiles= 	./Makefile ./makefile ./MAKEFILE
Makefiles= 	./Makefile
GREP=		grep -s
WEBP_FILES := $(shell ls *.webp)
PNG_FILES= $(WEBP_FILES:%webp=%png)

.wepb.png:
	@convert $< $@

pngs: $(PNG_FILES)
	echo $(PNG_FILES)

targets:
	-@$(GREP) '^[^	#][^=:]*:[ 	]' $(Makefiles)

macros:
	-$(GREP) '^[^#].*=' $(Makefiles)

