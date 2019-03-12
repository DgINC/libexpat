#
#                          __  __            _
#                       ___\ \/ /_ __   __ _| |_
#                      / _ \\  /| '_ \ / _` | __|
#                     |  __//  \| |_) | (_| | |_
#                      \___/_/\_\ .__/ \__,_|\__|
#                               |_| XML parser
#
# Copyright (c) 2017 Expat development team
# Licensed under the MIT license:
#
# Permission is  hereby granted,  free of charge,  to any  person obtaining
# a  copy  of  this  software   and  associated  documentation  files  (the
# "Software"),  to  deal in  the  Software  without restriction,  including
# without  limitation the  rights  to use,  copy,  modify, merge,  publish,
# distribute, sublicense, and/or sell copies of the Software, and to permit
# persons  to whom  the Software  is  furnished to  do so,  subject to  the
# following conditions:
#
# The above copyright  notice and this permission notice  shall be included
# in all copies or substantial portions of the Software.
#
# THE  SOFTWARE  IS  PROVIDED  "AS  IS",  WITHOUT  WARRANTY  OF  ANY  KIND,
# EXPRESS  OR IMPLIED,  INCLUDING  BUT  NOT LIMITED  TO  THE WARRANTIES  OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
# NO EVENT SHALL THE AUTHORS OR  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR  OTHER LIABILITY, WHETHER  IN AN  ACTION OF CONTRACT,  TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
# USE OR OTHER DEALINGS IN THE SOFTWARE.

cmake_minimum_required(VERSION 3.10.3)

project("libexpat" C)

set(LIBEXPAT_VERSION_MAJOR "2")
set(LIBEXPAT_VERSION_MINOR "2")
set(LIBEXPAT_VERSION_PATCH "6")
set(LIBEXPAT_VERSION ${LIBEXPAT_VERSION_MAJOR}.${LIBEXPAT_VERSION_MINOR}.${LIBEXPAT_VERSION_PATCH})

include(GNUInstallDirs)

option(BUILD_TOOLS "build the xmlwf tool for expat library" ON)
option(BUILD_TEST "build the tests for expat library" ON)
option(BUILD_SHARED "build a shared expat library" ON)
option(INSTALL "install expat files in cmake install target" ON)

#
#  DOCUMENTATION
#
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/docs/doxygen/)


if(UNIX AND NOT APPLE)
    option(USE_LIBBSD "utilize libbsd (for arc4random_buf)" OFF)
    if(USE_LIBBSD)
        find_library(LIB_BSD NAMES bsd)
        if(NOT LIB_BSD)
            message(FATAL_ERROR "USE_LIBSD option is enabled, but libbsd was not found")
        else()
            set(HAVE_LIBBSD TRUE)
            target_link_libraries(libexpat ${LIB_BSD})
        endif()
    endif()
endif()

# configuration options
set(XML_CONTEXT_BYTES 1024 CACHE STRING "Define to specify how much context to retain around the current parse point")
option(XML_DTD "Define to make parameter entity parsing functionality available" ON)
option(XML_NS "Define to make XML Namespaces functionality available" ON)
option(WARNINGS_AS_ERRORS "Treat all compiler warnings as errors" OFF)
if(NOT WIN32)
    option(XML_DEV_URANDOM "Define to include code reading entropy from `/dev/urandom'." ON)
    if(XML_DEV_URANDOM)
        set(XML_DEV_URANDOM 1)
    else(XML_DEV_URANDOM)
        set(XML_DEV_URANDOM 0)
    endif(XML_DEV_URANDOM)
endif()
option(XML_UNICODE "Use UTF-16 encoded chars (two bytes) instead of UTF-8" OFF)
option(XML_UNICODE_WCHAR_T "Use wchar_t to represent UTF-16 instead of unsigned short" OFF)

if(XML_DTD)
    set(XML_DTD 1)
else(XML_DTD)
    set(XML_DTD 0)
endif(XML_DTD)
if(XML_NS)
    set(XML_NS 1)
else(XML_NS)
    set(XML_NS 0)
endif(XML_NS)
if(XML_UNICODE)
    set(XML_UNICODE 1)
else(XML_UNICODE)
    set(XML_UNICODE 0)
endif(XML_UNICODE)
if(XML_UNICODE_WCHAR_T)
    set(XML_UNICODE_WCHAR_T 1)
else(XML_UNICODE_WCHAR_T)
    set(XML_UNICODE_WCHAR_T 0)
endif(XML_UNICODE_WCHAR_T)

if(XML_UNICODE_WCHAR_T AND NOT XML_UNICODE)
    message(SEND_ERROR "Option XML_UNICODE_WCHAR_T=ON may not be used without XML_UNICODE=ON.")
    set(XML_UNICODE 1)
endif(XML_UNICODE_WCHAR_T AND NOT XML_UNICODE)

if(BUILD_TOOLS AND (XML_UNICODE AND NOT XML_UNICODE_WCHAR_T))
    message(SEND_ERROR "The xmlwf tool can not be built with option XML_UNICODE_WCHAR_T=OFF and XML_UNICODE=ON. Either set XML_UNICODE_WCHAR_T=ON or BUILD_TOOLS=OFF.")
endif()

if(BUILD_TEST)
    enable_testing()
endif(BUILD_TEST)

include(${CMAKE_CURRENT_LIST_DIR}/ConfigureChecks.cmake)

set(EXTRA_COMPILE_FLAGS)
if(FLAG_NO_STRICT_ALIASING)
    set(EXTRA_COMPILE_FLAGS "${EXTRA_COMPILE_FLAGS} -fno-strict-aliasing")
endif()
if(FLAG_VISIBILITY)
  add_definitions(-DXML_ENABLE_VISIBILITY=1)
  set(EXTRA_COMPILE_FLAGS "${EXTRA_COMPILE_FLAGS} -fvisibility=hidden")
endif(FLAG_VISIBILITY)
if (WARNINGS_AS_ERRORS)
    if(MSVC)
        add_definitions(/WX)
    else(MSVC)
        set(EXTRA_COMPILE_FLAGS "${EXTRA_COMPILE_FLAGS} -Werror")
    endif(MSVC)
endif(WARNINGS_AS_ERRORS)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${EXTRA_COMPILE_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${EXTRA_COMPILE_FLAGS}")

if (MSVC)
	set(MSVC_USE_STATIC_CRT OFF CACHE BOOL "Use /MT flag (static CRT) when compiling in MSVC")
    if (MSVC_USE_STATIC_CRT)
        message("-- Using static CRT ${MSVC_USE_STATIC_CRT}")
        foreach(flag_var
                CMAKE_CXX_FLAGS_DEBUG
                CMAKE_CXX_FLAGS_RELEASE
                CMAKE_CXX_FLAGS_MINSIZEREL
                CMAKE_CXX_FLAGS_RELWITHDEBINFO
                CMAKE_C_FLAGS_DEBUG
                CMAKE_C_FLAGS_RELEASE
                CMAKE_C_FLAGS_MINSIZEREL
                CMAKE_C_FLAGS_RELWITHDEBINFO
                )
            string(REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
        endforeach()
    endif()
endif()

include_directories(${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/src/libexpat)
if(MSVC)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS -wd4996)
endif(MSVC)
if(WIN32)
    set(CMAKE_DEBUG_POSTFIX "d" CACHE STRING "Add a suffix, usually d on Windows")
endif(WIN32)

set(libexpat_SRCS
    src/libexpat/loadlibrary.c
    src/libexpat/xmlparse.c
    src/libexpat/xmlrole.c
    src/libexpat/xmltok.c
    src/libexpat/xmltok_impl.c
    src/libexpat/xmltok_ns.c
)

if(BUILD_SHARED)
    set(_SHARED SHARED)
    if(WIN32)
        set(libexpat_SRCS ${libexpat_SRCS} tools/platform/win/libexpat.def)
    endif(WIN32)
else(BUILD_SHARED)
    set(_SHARED STATIC)
    if(WIN32)
        add_definitions(-DXML_STATIC)
    endif(WIN32)
endif(BUILD_SHARED)

add_library(libexpat ${_SHARED} ${libexpat_SRCS})


if(NOT WIN32)
    set_property(TARGET libexpat PROPERTY VERSION ${LIBEXPAT_VERSION})
    set_property(TARGET libexpat PROPERTY SOVERSION ${LIBEXPAT_VERSION_MAJOR})
    set_property(TARGET libexpat PROPERTY NO_SONAME ${NO_SONAME})
endif(NOT WIN32)

macro(expat_install)
    if(INSTALL)
        install(${ARGN})
    endif()
endmacro()

expat_install(TARGETS libexpat RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
                      LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
                      ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

set(prefix ${CMAKE_INSTALL_PREFIX})
set(exec_prefix "\${prefix}")
set(libdir "\${exec_prefix}/${CMAKE_INSTALL_LIBDIR}")
set(includedir "\${prefix}/${CMAKE_INSTALL_INCLUDEDIR}")
configure_file(libexpat.pc.in ${CMAKE_CURRENT_BINARY_DIR}/libexpat.pc @ONLY)

configure_file("${PROJECT_SOURCE_DIR}/libexpat_config.h.in" "${PROJECT_BINARY_DIR}/libexpat_config.h")

expat_install(FILES src/libexpat/expat.h src/libexpat/expat_external.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
expat_install(FILES ${CMAKE_CURRENT_BINARY_DIR}/libexpat.pc DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig)

if(BUILD_TOOLS)
    set(XMLWF_SRCS
        src/xmlwf/xmlwf.c
        src/xmlwf/xmlfile.c
        src/xmlwf/codepage.c
        src/xmlwf/readfilemap.c
    )

    add_executable(xmlwf ${XMLWF_SRCS})
    set_property(TARGET xmlwf PROPERTY RUNTIME_OUTPUT_DIRECTORY xmlwf)
    target_link_libraries(xmlwf libexpat)
    expat_install(TARGETS xmlwf DESTINATION ${CMAKE_INSTALL_BINDIR})
endif()

if(BUILD_TEST)
    ## these are unittests that can be run on any platform
    add_executable(runtests src/tests/runtests.c src/tests/chardata.c src/tests/structdata.c src/tests/minicheck.c src/tests/memcheck.c)
    set_property(TARGET runtests PROPERTY RUNTIME_OUTPUT_DIRECTORY tests)
    target_link_libraries(runtests libexpat)
    add_test(runtests src/tests/runtests)

    add_executable(runtestspp src/tests/runtestspp.cpp src/tests/chardata.c src/tests/structdata.c src/tests/minicheck.c src/tests/memcheck.c)
    set_property(TARGET runtestspp PROPERTY RUNTIME_OUTPUT_DIRECTORY tests)
    target_link_libraries(runtestspp libexpat)
    add_test(runtestspp src/tests/runtestspp)
endif(BUILD_TEST)
