[![Travis CI Build Status](https://travis-ci.org/libexpat/libexpat.svg?branch=master)](https://travis-ci.org/libexpat/libexpat)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/libexpat/libexpat?svg=true)](https://ci.appveyor.com/project/libexpat/libexpat)
[![Packaging status](https://repology.org/badge/tiny-repos/expat.svg)](https://repology.org/metapackage/expat/versions)


# Expat, Release 2.2.6

This is Expat, a C library for parsing XML, started by
[James Clark](https://en.wikipedia.org/wiki/James_Clark_(programmer)) in 1997.
Expat is a stream-oriented XML parser.  This means that you register
handlers with the parser before starting the parse.  These handlers
are called when the parser discovers the associated structures in the
document being parsed.  A start tag is an example of the kind of
structures for which you may register handlers.

Windows users should use the
[`expat_win32` package](https://sourceforge.net/projects/expat/files/expat_win32/),
which includes both precompiled libraries and executables, and source code for
developers.

Expat is [free software](https://www.gnu.org/philosophy/free-sw.en.html).
You may copy, distribute, and modify it under the terms of the License
contained in the file
[`COPYING`](https://github.com/libexpat/libexpat/blob/master/expat/COPYING)
distributed with this package.
This license is the same as the MIT/X Consortium license.

== How to build expat with CMake ==

The cmake based buildsystem for expat works on Windows (cygwin, mingw, Visual 
Studio) and should work on all other platform cmake supports.

Assuming ~/expat-2.2.6 is the source directory of expat, add a subdirectory
build and change into that directory:
~/expat-2.2.6$ mkdir build && cd build
~/expat-2.2.6/build$

From that directory, call cmake first, then call make, make test and 
make install in the usual way:
~/expat-2.2.6/build$ cmake ..
-- The C compiler identification is GNU
-- The CXX compiler identification is GNU
....
-- Configuring done
-- Generating done
-- Build files have been written to: /home/patrick/expat-2.2.6/build

If you want to specify the install location for your files, append 
-DCMAKE_INSTALL_PREFIX=/your/install/path to the cmake call.

~/expat-2.2.6/build$ make && make test && make install
Scanning dependencies of target expat
[  5%] Building C object CMakeFiles/expat.dir/lib/xmlparse.c.o
[ 11%] Building C object CMakeFiles/expat.dir/lib/xmlrole.c.o
....
-- Installing: /usr/local/lib/pkgconfig/expat.pc
-- Installing: /usr/local/bin/xmlwf
-- Installing: /usr/local/share/man/man1/xmlwf.1

For Windows builds, you must make sure to call cmake from an environment where 
your compiler is reachable, that means either you call it from the 
Visual Studio Command Prompt or when using mingw, you must open a cmd.exe and
make sure that gcc can be called. On Windows, you also might want to specify a 
special Generator for CMake:
for Visual Studio builds do: 
cmake .. -G "Visual Studio 10" && vcexpress expat.sln
for mingw builds do: 
cmake .. -G "MinGW Makefiles" -DCMAKE_INSTALL_PREFIX=D:\expat-install 
    && gmake && gmake install