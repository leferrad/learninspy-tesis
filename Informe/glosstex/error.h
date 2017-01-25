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

/* $Id: error.h,v 1.8 1997/06/09 19:54:10 yavuzv Exp $ */

#ifndef __ERROR_H
#define __ERROR_H

enum e_loglevel {
  ERROR = 0, WARNING, PROGRESS, INFORMATION, VERBOSE, DEBUG
};
enum e_output_to {
  STDOUT = 1, LOGFILE = 2
};

void error (const char *fmt,...);
void printlog (enum e_loglevel, int output_to, const char *fmt,...);

#endif /* not __ERROR_H */
