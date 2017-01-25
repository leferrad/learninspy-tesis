/* -*- c -*- */

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

/* $Id: labels.h,v 1.18 1997/12/13 16:06:56 volkan Exp $ */

#ifndef __LABELS_H
#define __LABELS_H

#include "list.h"
#include <stdio.h>

/* values for label flags */
enum e_label_flag {
  UNRESOLVED = 0, RESOLVED
};
enum e_find_mode {
  FIND_FIRST, FIND_NEXT
};

typedef struct s_label_s {
  char *label;
  char *pageref_mode;
  char *list;
  char *list_mode;
  char *page;
  enum e_label_flag flag;
} s_label;

int read_labels (char *inname);
s_label *find_label (s_list_iterator * iterator, enum e_find_mode find_mode,
		     char *label, char *list);
unsigned int show_unresolved_labels (s_list list, FILE * file);

#endif /* not __LABELS_H */
