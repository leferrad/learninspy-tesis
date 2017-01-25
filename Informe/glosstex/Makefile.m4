# -*- Makefile -*-
m4_ifelse(1, 1,
# automatically generated from Makefile.m4
,
# $Id: Makefile.m4,v 1.35 1998/01/06 18:08:49 volkan Exp $

# GlossTeX, a tool for the automatic preparation of glossaries.
# Copyright (C) 1997 Volkan Yavuz

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License[,] or (at your option) any later version.

# This program is distributed in the hope that it will be useful[,]
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not[,] write to the Free Software
# Foundation[,] Inc.[,] 675 Mass Ave[,] Cambridge[,] MA 02139[,] USA.

# Volkan Yavuz[,] yavuzv@rumms.uni-mannheim.de
)
# ======================================================================
# you may need to set some of these
# ======================================================================

m4_changequote([,])
m4_ifdef([MASTER],
include Release
)
CFLAGS += -Wall -ansi -pedantic

m4_ifdef([MASTER],
DEBUG = 
THISDIR = ./

ifdef DEBUG
 CFLAGS += -g
 LDFLAGS += -g
endif
)
m4_ifelse(OSTYPE, [UNX],
CC = cc
SHELL = /bin/bash
THISDIR = ./
)
m4_ifelse(OSTYPE, [OS2],
CC = gcc
SHELL = sh
EXE = .exe
EMXBIND = emxbind
)
m4_ifdef([MASTER],
M4 = m4
)
LATEXENV = TEXINPUTS=.:
LATEX = $(LATEXENV) latex

m4_ifdef([MASTER],
MAKEINDEX = makeindex
GLOSSTEX = $(THISDIR)glosstex$(EXE)
MV = mv
RM = rm -f
)

# ======================================================================
# you shouldn't need to touch anything below
# ======================================================================

TEXAUX = *.aux *.lof *.lot *.log *.toc *.glo 
GLOSSTEXAUX = *.gxs *.gxg
MAKEINDEXAUX = *.glg *.glx *.ilg *.ind

m4_ifdef([MASTER],
MAKEFILESX=\
	Makefile\
	Makefile.os2\
	Makefile.unx

READMES=\
	README\
	LIESMICH
)
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

m4_ifelse(OSTYPE, [OS2],
glosstex$(EXE): glosstex
	$(EMXBIND) $<
	$(EMXBIND) -s $<
	$(RM) glosstex
)

$(DTX): glosstex.dtx glosstex.ins
	$(LATEX) glosstex.ins


m4_ifdef([MASTER],
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
)
