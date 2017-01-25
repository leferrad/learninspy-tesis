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

/* $Id: list.h,v 1.13 1997/10/26 15:01:03 volkan Exp $ */

#ifndef __LIST_H
#define __LIST_H

typedef struct s_node_s {
  void *ptr;
  struct s_node_s *next;
} s_node;

typedef struct s_list_s {
  s_node *root;
  s_node *top;
} s_list;

typedef struct s_list_iterator_s {
  s_node *root;
  s_node *current;
} s_list_iterator;

extern void *list_add (s_list * list, void *ptr);

#endif /* not __LIST_H */
