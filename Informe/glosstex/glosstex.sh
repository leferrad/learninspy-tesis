#!/bin/sh

# $Id: glosstex.sh,v 1.4 1997/11/08 14:33:39 volkan Exp $
# makeindex -- a Kpathsea wrapper for the makindex index processor.
# (C) 1996, Thomas Esser. Idea and first version by Matthias Clasen.
# adaption for glosstex by Volkan Yavuz

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

# We need to search for makeindex.bin, since I want to create a
# symlink to it. The reason behind is to call makeindex.bin via
# that symlink (its name will be makeindex) to get "makeindex"
# in the verbose output, rather than "makeindex.bin"

check_for_binary()
{
  testbin=$1;
  set x `echo "$PATH" | sed 's/^:/.:/; s/:$/:./; s/::/:.:/g; s/:/ /g'`; shift
  for i
  do
    if [ -x "$i/$testbin" ]; then
      echo "$i/$testbin"
      return 0
    fi
  done
  return 1
}

# for kpsetool and verbose messages:
prog=`basename $0`

# We search along "kpsetool -w tex ...", so map GDFINPUTS into TEXINPUTS.
GDFINPUTS=`kpsetool -v -n $prog '$GDFINPUTS'`
test -n "$GDFINPUTS" && { TEXINPUTS="$GDFINPUTS"; export TEXINPUTS; }
unset GDFINPUTS

glsstxbin=`check_for_binary $prog.bin`
if test ! -x "$glsstxbin"; then
  echo "$prog: cannot execute $prog.bin. Aborted." >&2
  exit 1
fi
TEMPDIR=${TMPDIR-/tmp}/glsstx.$$
trap 'cd /; rm -rf $TEMPDIR' 1 2 15
test -d $TEMPDIR || mkdir $TEMPDIR
ln -s $glsstxbin $TEMPDIR/$prog

# The following is needed to handle envvars like GDFINPUTS=~: correctly.
# We put the GDFINPUTS from texmf.cnf into a temp. config file and
# set TEXMFCNF:
echo "TEXINPUTS = `kpsetool -v -n $prog '$GDFINPUTS'`" > $TEMPDIR/texmf.cnf
TEXMFCNF="$TEMPDIR:$TEXMFCNF"; export TEXMFCNF

# If KPATHSEA_DEBUG is set, do not redirect kpsetool's stderr to /dev/null.
debug=
test "x${KPATHSEA_DEBUG}${KPATHSEA_DEBUG-x}" = xx && debug='2>/dev/null'

# Analyze the positional arguments.
unset expargs
expargs="$expargs $1"
shift

while test "x$1" != x; do
  case "$1" in
  -v*) 
    expargs="$expargs $1"
    shift;;

  *)
    case "$1" in
    *.gdf)
      eval gdffile=\`kpsetool -w -n $prog tex \"$1\" $debug\`;;
    *)
      eval gdffile=\`kpsetool -w -n $prog tex \"$1.gdf\" $debug\`
      { test -n "$gdffile" && test -f "$gdffile"; } ||
        eval gdffile=\`kpsetool -w -n $prog tex \"$1\" $debug\`;;
    esac

    if test -z "$gdffile" || test ! -f "$gdffile"; then
      echo "GlossTeX database file $1 not found." >&2
      echo "Usage: $prog aux gdf0 [gdf1 ...] [-v[0-5]]" >&2
      exit 1
    fi

    # remove ./ from the filename: it is part of the verbose messages...
    gdffile=`echo "$gdffile" | sed 's/^\.\///'`
    expargs="$expargs $gdffile"
    shift;;
  esac
done

$TEMPDIR/$prog $expargs
#echo $TEMPDIR/$prog $expargs
rm -rf $TEMPDIR
