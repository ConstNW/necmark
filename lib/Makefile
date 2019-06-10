include Makefile-platform.mk
include Makefile-ndll.mk

PROJECT=necmark

ifeq ($(PLATFORM), $(filter $(PLATFORM), Windows Windows64))

	ifeq ($(PLATFORM),Windows64)
		NEKOPATH=d:\devel\neko-x64
		DEPPATH=dep\cmark-win
	else
		NEKOPATH=d:\devel\neko
		DEPPATH=dep\cmark-win
	endif

	CCFLAGS+=-I$(DEPPATH)\include -DCMARK_STATIC_DEFINE -O2
	LDFLAGS+=$(DEPPATH)\lib\libcmark.a

else
	ifeq ($(PLATFORM), $(filter $(PLATFORM), Linux Linux64))
		NEKOPATH=/usr/lib/x86_64-linux-gnu/neko/
		DEPPATH=dep/cmark-lin

		CCFLAGS+=-I$(DEPPATH)/include -DCMARK_STATIC_DEFINE -O2
		LDFLAGS+=$(DEPPATH)/lib/libcmark.a
	endif
endif

platform:
	echo "$(PLATFORM) $(OS) $(PROCESSOR_ARCHITECTURE)"
