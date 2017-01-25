/* -*- c-*- */

/*
   GlossTeX, a tool for the automatic preparation of glossaries.
   Copyright (C) 1997 Volkan Yavuz

   This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License
   as published by the Free Software Foundation; either version 2
   of the License, or (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

   Volkan Yavuz, yavuzv@rumms.uni-mannheim.de
 */

/* $Id: error.c,v 1.16 1997/12/24 18:09:18 volkan Exp $ */

#include "glosstex.h"
#include "error.h"
#include <errno.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>

#define BUFSIZE 4096

extern char* sys_errlist[];

void
error (const char *fmt,...)
{
  char buf[BUFSIZE];
  int errno_save = errno;

  va_list ap;
  va_start (ap, fmt);

  sprintf (buf, "\n%s: ", progname);
  (void) vsprintf (buf + strlen (buf), fmt, ap);

#if _HAVE_STRERROR_
  sprintf (buf + strlen (buf), ": %s\n", strerror (errno_save));
#else
  sprintf (buf + strlen (buf), ": %s\n", sys_errlist[errno_save]);
#endif

  (void) fflush (stdout);
  (void) fputs (buf, stderr);

#if _HAVE_ANSI_C_FFLUSH_
  (void) fflush (0);		/* flush all streams */
#else
  (void) fflush (stdout);
  (void) fflush (stderr);
#endif

  va_end (ap);
}

void
printlog (enum e_loglevel level, int output_to, const char *fmt,...)
{
  va_list ap;
  va_start (ap, fmt);

  if ((level <= loglevel) && (output_to & STDOUT))
    (void) vfprintf (stdout, fmt, ap);

  if ((level <= loglevel + 1) && (output_to & LOGFILE))
    (void) vfprintf (logfile, fmt, ap);
}
