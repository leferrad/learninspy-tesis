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

/* $Id: config.h,v 1.5 1997/12/24 18:11:11 volkan Exp $ */

#ifndef __CONFIG_H
#define __CONFIG_H

/* needed for some of the includes that came with gcc-2.7.2.1 */
#define __USE_FIXED_PROTOTYPES__

/* set this to 1 if your libc has strerror (defined in string.h) 
   otherwise, we may go along with extern char* sys_errlist[] 
   this is necessary on SunOS 4.1.3 which has no strerror */
#define _HAVE_STRERROR_ 1

/* set this to 1 if your libc has an ANSI C conforming int
   fflush(FILE* fp). ANSI C conforming in this case means that fflush
   should be able a accept a NULL pointer which causes all open
   streams to be flushed instead of just fp. If your libc isn't ANSI
   conforming (like e.g. SunOS 4.1.3) passing fflush a NULL pointer
   will cause a core dump. */
#define _HAVE_ANSI_C_FFLUSH_ 1

#endif /* not __CONFIG_H */
