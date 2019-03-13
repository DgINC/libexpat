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

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../src/libexpat/)

set(TEST_SOURCES
    chardata.c
    structdata.c
    minicheck.c
    memcheck.c
    )

find_package(Check)
if(CHECK_FOUND)
    include_directories(${CHECK_INCLUDE_DIRS})
    link_directories(${CHECK_LIBRARY_DIRS})
else(CHECK_FOUND)
    include(ExternalProject)

    file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/external)
    
    set(EXTERNAL_INSTALL_LOCATION ${CMAKE_BINARY_DIR}/external)

    ExternalProject_Add(check
        GIT_REPOSITORY https://github.com/libcheck/check.git
        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTERNAL_INSTALL_LOCATION}
    )

    include_directories(${EXTERNAL_INSTALL_LOCATION}/include)
    link_directories(${EXTERNAL_INSTALL_LOCATION}/lib)
endif(CHECK_FOUND)

add_executable(runtests runtests.c ${TEST_SOURCES})
set_property(TARGET runtests PROPERTY RUNTIME_OUTPUT_DIRECTORY tests)
add_dependencies(runtests check)
target_link_libraries(runtests libexpat ${EXTERNAL_INSTALL_LOCATION}/lib)

add_executable(runtestspp runtestspp.cpp ${TEST_SOURCES})
set_property(TARGET runtestspp PROPERTY RUNTIME_OUTPUT_DIRECTORY tests)
add_dependencies(runtestspp check)
target_link_libraries(runtestspp libexpat ${EXTERNAL_INSTALL_LOCATION}/lib)
