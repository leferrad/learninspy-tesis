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

/* $Id: main.c,v 1.31 1997/12/13 16:06:57 volkan Exp $ */

#include "glosstex.h"
#include "database.h"
#include "error.h"
#include "labels.h"
#include "list.h"
#include "version.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

enum e_loglevel loglevel = PROGRESS;

s_list labels;			/* list of all labels found */
s_list databases;		/* list of all databases */

char *progname = 0;		/* name this prog was called with */

char *inname = 0;		/* name of root input (.aux) file */
char *outname = 0;		/* name of output file */
char *logname = 0;		/* name of logfile */

FILE *outfile;
FILE *logfile;

unsigned int count_label_parsing = 0;	/* parsing failed */
unsigned int count_label_defined = 0;	/* label already defined */
unsigned int count_label_override = 0;	/* label overridden */
unsigned int count_label_success = 0;	/* success */
unsigned int count_label_unresolved = 0;	/* unresolved labels */

unsigned int count_gdf_parsing;	/* parsing failed */
unsigned int count_gdf_defined;	/* term already defined */
unsigned int count_gdf_success;	/* success */

char usage[] = "Usage: %s aux gdf0 [gdf1 ...] [-v[0-5]]\n";

static void parse_commandline (int argc, char **argv);
static void open_files (void);
static char *check_extension (const char *string, const char *ext);
static char *build_filename (const char *string, const char *ext);

int
main (int argc, char *argv[])
{
  labels.root = labels.top = 0;
  databases.root = databases.top = 0;

  assert (argv[0] != 0);
  progname = (char *) malloc (strlen (argv[0]) + 1);

  assert (progname != 0);
  strcpy (progname, argv[0]);

  printf ("%s\n", version);

  parse_commandline (argc, argv);

  open_files ();

  if (read_labels (inname) != 0) {
    if (unlink(outname) != 0) {
      error ("output-file %s", outname);
      exit (EXIT_FAILURE);
    }
    if (unlink(logname) != 0) {
      error ("logfile %s", outname);
      exit (EXIT_FAILURE);
    }
    exit (EXIT_FAILURE);
  }

  printlog (PROGRESS, STDOUT,
	    "\n(parse errors:%d, overrides: %d, success:%d)\n\n",
	    count_label_parsing, count_label_override, count_label_success);
  
  read_databases ();
  printlog (PROGRESS, STDOUT,
	    "\n(parse errors:%d, terms already defined: %d, success:%d)\n",
	    count_gdf_parsing, count_gdf_defined, count_gdf_success);

  if ((count_label_unresolved = show_unresolved_labels (labels, logfile)) != 0)
    printlog (PROGRESS, STDOUT, "\n(unresolved labels: %d)",
	      count_label_unresolved, logname);

  printlog (PROGRESS, STDOUT,
	    "\nWrote output-file %s, log-file %s\n", outname, logname);

  return 0;
}

static void
parse_commandline (int argc, char **argv)
{
  int index;

  if (argc < 3) {
    fprintf (stderr, usage, progname);
    exit (EXIT_FAILURE);
  }
  inname = check_extension (argv[1], ".aux");

  for (index = 2; index < argc; index++) {
    if (strncmp (argv[index], "-v0", 3) == 0)
      loglevel = ERROR;
    else if (strncmp (argv[index], "-v1", 3) == 0)
      loglevel = WARNING;
    else if (strncmp (argv[index], "-v2", 3) == 0)
      loglevel = PROGRESS;
    else if (strncmp (argv[index], "-v3", 3) == 0)
      loglevel = INFORMATION;
    else if (strncmp (argv[index], "-v4", 3) == 0)
      loglevel = VERBOSE;
    else if (strncmp (argv[index], "-v5", 3) == 0)
      loglevel = DEBUG;
    else if (strncmp (argv[index], "-v", 2) == 0)
      loglevel = VERBOSE;
    else
      (void) list_add (&databases, check_extension (argv[index], ".gdf"));
  }

}

static void
open_files (void)
{
  if (outname == 0)
    outname = build_filename (inname, ".gxs");

  if ((outfile = fopen (outname, "w")) == NULL) {
    error ("output-file %s", outname);
    exit (EXIT_FAILURE);
  }

  if (logname == 0)
    logname = build_filename (inname, ".gxg");

  if ((logfile = fopen (logname, "w")) == NULL) {
    error ("log-file %s", logname);
    exit (EXIT_FAILURE);
  }
}

static char *
check_extension (const char *string, const char *ext)
{
  char *new = 0;

  if (strchr (string, '.') == 0) {
    new = (char *) malloc (strlen (string) + strlen (ext) + 1);
    assert (new != 0);
    strcpy (new, string);
    strcat (new, ext);
  } else {
    new = (char *) malloc (strlen (string) + 1);
    assert (new != 0);
    strcpy (new, string);
  }
  return new;
}

static char *
build_filename (const char *string, const char *ext)
{
  char *filename = 0;
  size_t len;

  len = strcspn (string, ".");
  assert (len != 0);

  filename = (char *) malloc (len + strlen (ext) + 1);
  assert (filename != 0);

  strncpy (filename, string, len);
  filename[len] = '\0';		/* mark end of string */
  strcat (filename, ext);

  return filename;
}
