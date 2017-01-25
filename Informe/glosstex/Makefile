# -*- Makefile -*-
# automatically generated from Makefile.m4

# ======================================================================
# you may need to set some of these
# ======================================================================


include Release

CFLAGS += -Wall -ansi -pedantic

DEBUG = 
THISDIR = ./

ifdef DEBUG
 CFLAGS += -g
 LDFLAGS += -g
endif



M4 = m4

LATEXENV = TEXINPUTS=.:
LATEX = $(LATEXENV) latex

MAKEINDEX = makeindex
GLOSSTEX = $(THISDIR)glosstex$(EXE)
MV = mv
RM = rm -f


# ======================================================================
# you shouldn't need to touch anything below
# ======================================================================

TEXAUX = *.aux *.lof *.lot *.log *.toc *.glo 
GLOSSTEXAUX = *.gxs *.gxg
MAKEINDEXAUX = *.glg *.glx *.ilg *.ind

MAKEFILESX=\
	Makefile\
	Makefile.os2\
	Makefile.unx

READMES=\
	README\
	LIESMICH

O=\
	database.o\
	error.o\
	labels.o\
	list.o\
	main.o\
	version.o

DTX=\
	glosstex.sty\
	glosstex.std\
	glosstex.ist\
	glosstex.gdf

C=$(O:%.o=%.c)

all: glosstex$(EXE) $(DTX)

glosstex: $(O)
	$(CC) $(LDFLAGS) $(O) $(LOADLIBS) -o $@



$(DTX): glosstex.dtx glosstex.ins
	$(LATEX) glosstex.ins


doc: glosstex$(EXE) glosstex.dvi

glosstex.dvi: $(DTX) glosstex.dtx

%.dvi: %.dtx
	$(LATEX) $<
	$(GLOSSTEX) $*.aux $*.gdf
	$(MAKEINDEX) $*.gxs -o $*.glx -t $*.glg -s glosstex.ist
	$(LATEX) $<
	$(GLOSSTEX) $*.aux $*.gdf
	$(MAKEINDEX) $*.gxs -o $*.glx -t $*.glg -s glosstex.ist
	$(LATEX) $<

clean:
	$(RM) $(O) $(TEXAUX) $(MAKEINDEXAUX) $(GLOSSTEXAUX) $(DTX) *~

proper: clean
	$(RM) $(GLOSSTEX) glosstex.dvi

makefiles: $(MAKEFILESX)

Makefile: Makefile.m4
	$(M4) -P -DMASTER $< > $@

Makefile.os2: Makefile.m4
	$(M4) -P -DOSTYPE=OS2 $< > $@

Makefile.unx: Makefile.m4
	$(M4) -P -DOSTYPE=UNX $< > $@

readmes: $(READMES)

README: README.m4
	$(M4) -P -DENGLISH $< > README

LIESMICH: README.m4
	$(M4) -P -DGERMAN $< > LIESMICH

dist: makefiles dep all $(READMES) doc
	@UNAME_MACHINE=`(uname -m) 2>/dev/null` || UNAME_MACHINE=unknown;\
	UNAME_SYSTEM=`(uname -s) 2>/dev/null` || UNAME_SYSTEM=unknown;\
	UNAME_RELEASE=`(uname -r) 2>/dev/null` || UNAME_RELEASE=unknown;\
	SYSTEM=$$UNAME_MACHINE-$$UNAME_SYSTEM-$$UNAME_RELEASE;\
	mkdir /tmp/glosstex-$$$$;\
	mkdir /tmp/glosstex-$$$$/glosstex-$(RELEASE);\
	cp -rp * .depend /tmp/glosstex-$$$$/glosstex-$(RELEASE);\
	pushd /tmp/glosstex-$$$$/glosstex-$(RELEASE);\
	rm -rf CVS bin/CVS test;\
	mv glosstex$(EXE) bin/glosstex-$$SYSTEM;\
	$(MAKE) clean;\
	cd ..;\
	tar czf glosstex-$(RELEASE).tar.gz glosstex-$(RELEASE);\
	popd;\
	mv /tmp/glosstex-$$$$/glosstex-$(RELEASE).tar.gz ..;\
	echo released glosstex-$(RELEASE) for $$SYSTEM

dep:
	$(CPP) -MM $(INCDIR) $(C) > .depend

lint:
	lint $(C) 

version.c : Release
	$(MV) $@ $@.in
	sed < $@.in > $@ -e 's/version .*\\n/version $(RELEASE)\\n/'
	$(RM) $@.in

glosstex.dtx : Release
	$(MV) $@ $@.in
	sed < $@.in > $@\
	-e 's/\\def\\fileversion{.*}/\\def\\fileversion{$(RELEASE)}/'\
	-e 's/\\def\\filedate{.*}/\\def\\filedate{'`date '+%Y\/%m\/%d'`'}/'
	$(RM) $@.in

ifeq (.depend, $(wildcard .depend))
include .depend
endif

