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

find_package(Doxygen)

if(DOXYGEN_FOUND)

  ########################################################################
  # Create the doxygen configuration file
  ########################################################################
  file(TO_NATIVE_PATH ${CMAKE_SOURCE_DIR} top_srcdir)
  file(TO_NATIVE_PATH ${CMAKE_BINARY_DIR} top_builddir)
  file(TO_NATIVE_PATH ${CMAKE_SOURCE_DIR} abs_top_srcdir)
  file(TO_NATIVE_PATH ${CMAKE_BINARY_DIR} abs_top_builddir)

  set(HAVE_DOT ${DOXYGEN_DOT_FOUND})
  set(enable_html_docs YES)
  set(enable_latex_docs NO)
  set(enable_xml_docs NO)

  set(doxyfile_in ${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.cmake.in)
  set(doxyfile ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)

  SET(STATIC_PAGES  ${CMAKE_CURRENT_SOURCE_DIR}/footer/footer.html ${CMAKE_CURRENT_SOURCE_DIR}/header/header.html)

  set(DOXYGEN_GENERATE_LATEX NO
    #${enable_latex_docs}
    )
  set(DOXYGEN_GENERATE_XML NO 
    #${enable_xml_docs}
    )

  set(built_dirs
    ${CMAKE_CURRENT_BINARY_DIR}/html
    #<DOXYGEN_GENERATE_XML?${CMAKE_CURRENT_BINARY_DIR}/xml>
    )

  if(WIN32 AND NOT CYGWIN)
    set(DOXYGEN_GENERATE_MAN NO)
  elseif(UNIX AND NOT APPLE)
    set(DOXYGEN_GENERATE_MAN YES)
  endif()
  
  if(0)
    FILE(MAKE_DIRECTORY ${APIDOC_DIR}/html)
    CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/oai.css ${APIDOC_DIR}/html/oai.css COPYONLY)
    FILE(GLOB header_files RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/header/*.htm*)
    FILE(GLOB footer_files RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/footer/*.htm*)
    FILE(GLOB images_files RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/images/*.png)
  endif(0)

  configure_file(${doxyfile_in} ${doxyfile} @ONLY)


  ########################################################################
  # Make and install doxygen docs
  ########################################################################

  add_custom_command(
    OUTPUT  ${CMAKE_CURRENT_BINARY_DIR}/html/index.html
    COMMAND ${CMAKE_COMMAND} -E echo_append "Building DOXY API Documentation..."
    COMMAND ${DOXYGEN_EXECUTABLE} ${doxyfile}
    COMMAND ${CMAKE_COMMAND} -E echo "Done."
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMENT "Generating API documentation with Doxygen"
    #VERBATIM
    )

  add_custom_target(doc
    ALL
    DEPENDS ${doxyfile} ${CMAKE_CURRENT_BINARY_DIR}/html/index.html 
    )
  
  install(
    DIRECTORY ${built_dirs}
    DESTINATION share/doc/libexpat
    COMPONENT "docs"
    )
endif(DOXYGEN_FOUND)

