$Id: README.m4,v 1.5 1997/11/15 14:55:30 volkan Exp $

m4_changequote([,])
m4_ifdef([ENGLISH],
* Introduction

GlossTeX is a tool for the automatic preparation of glossaries[,] lists
of acronyms and sorted lists in general for use with LaTeX and
MakeIndex. In order to build GlossTeX[,] you need an ANSI C
compiler.

GlossTeX in some kind combines the functionality of acronym[,] nomencl
and GloTeX. Like GloTeX[,] it uses the same format glossary definition
files. GlossTeX can be used together with nomencl[,] nevertheless.

A term consists of a label which is used to identify it[,] an optional
typeset representation[,] an optional long-form (e.g. when it's an
acronym) and the actual text describing it. These elements can all be
accessed in several ways within the document. It is also possible to
place cross-references from one term to another and include
page-references into the produced lists. You can produce as many
independent lists as you like.

The most recent official release can always be found on
CTAN:/support/glosstex. Inofficial development releases may be found
on my homepage at http://webrum.uni-mannheim.de/ba/yavuzv/.

GlossTeX comes with absolutely no warranty and is covered by the GNU
General Public License (see the file COPYING).

		   Copyright (C) 1997 Volkan Yavuz
)
m4_ifdef([GERMAN],
* Einleitung

GlossTeX ist ein Tool für die automatische Erstellung eines
Glossars[,] Abk"urzungsverzeichnisses oder sortierten Listen im
Allgemeinen. Es wird zusammen mit LaTeX und MakeIndex verwendet. Um
GlossTeX zu compilieren ist ein ANSI C Compiler notwendig.

GlossTeX kombiniert die Funktionalität von acronym[,] nomencl und
GloTeX. Es verwendet dasselbe Format f"ur die Glossar-Datenbank wie
GloTeX. Trotzdem kann GlossTeX zusammen mit nomencl verwendet werden.

Ein Begriff besteht aus einem <label> zur Identifikation[,] einem
<item> für die Darstellung[,] einer optionalen ausgeschriebenen Form
(<long-form>) (z.B. bei Abk"urzungen) und einem beschreibenden
Text. Diese Elemente k"onnen innerhalb des Dokumentes auf vielf"altige
Weise angesprochen werden. Au"serdem ist es m"oglich[,]
Seitenreferenzen sowie Querverweise zwischen Begriffen zu
verwenden. Es sind beliebig viele unabh"angige Listen m"oglich.

Die aktuellste Version findet sich immer auf
CTAN:/support/glosstex. Inoffizielle Entwicklerversionen sind
evtl. "uber meine Homepage (http://webrum.uni-mannheim.de/ba/yavuzv/)
erhältlich.

F"ur GlossTeX wird KEINERLEI Gew"ahrleistung "ubernommen. Es
unterliegt der GNU General Public License (siehe Datei COPYING).

		   Copyright (C) 1997 Volkan Yavuz
)
m4_ifdef([ENGLISH],
* Usage

In your LaTeX-source[,] type:
)
m4_ifdef([GERMAN],
* Verwendung

Folgendes kommt in die LaTeX-Datei:
)
	\documentclass{article}
	\usepackage{glosstex}
	\begin{document}

	\printglosstex(acr)
	This document is typeset using \gls{LaTeX}.

	The database file\glosstex{gdf-file} for use with
	\gls{GlossTeX} is a flat \ac{ASCII} file.

	\printglosstex(glo)
	\end{document}

m4_ifdef([ENGLISH],
You need a .gdf-file that contains the definitions of the terms you
want to appear in the glossary. For example:

	@entry{LaTeX[,] \LaTeX{}} \LaTeX{} is a \TeX{}-format.

	@entry{ASCII[,] ASCII[,] American Standard Code for Information
	Interchange} ASCII is a character encoding. See also
	\glxref{EBCDIC}.
)
m4_ifdef([GERMAN],
Die .gdf-Datei enth"alt die Definitionen der Begriffe[,] die im Glossar
erscheinen.

	@entry{LaTeX[,] \LaTeX{}} \LaTeX{} ist ein \TeX{}-Format.

	@entry{ASCII[,] ASCII[,] American Standard Code for Information
	Interchange} ASCII ist eine Zeichensatzkodierung. Siehe auch
	\glxref{EBCDIC}.
)
m4_ifdef([ENGLISH],
You then run latex[,] glosstex[,] makeindex and latex again to build the
glossary. It may be necessary to use up to 4 iterations until all
references are resolved.
)
m4_ifdef([GERMAN],
Um das Glossar zu erstellen[,] werden latex[,] glosstex[,] makeindex und
schlie"slich ein weiteres Mal latex aufgerufen. Es kann n"otig sein[,]
dies bis zu 4 Mal zu wiederholen[,] bis alle Referenzen aufgel"ost sind.
)
m4_ifdef([ENGLISH],
* Documentation

Complete installation instructions and the user manual
can be found in glosstex.dvi.
)	
m4_ifdef([GERMAN],
* Dokumentation

Vollst"andige Installations- und Gebrauchsanweisungen befinden sich in
glosstex.dvi.
)
m4_ifdef([ENGLISH],
* Comments

If you have any comments[,] suggestions[,] mail me at
)	
m4_ifdef([GERMAN],
* Kommentare

Bei Anregungen[,] Kommentaren und sonstigem[,] bitte Mail an:
)
	yavuzv@rumms.uni-mannheim.de 
m4_ifdef([MASTER],
;;; Local Variables:
;;; mode: indented-text
;;; mode: outline-minor
;;; End:
)