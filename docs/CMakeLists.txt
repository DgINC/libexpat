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
#find_package(Latex)
#find_package(Dot)

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
  set(enable_xml_docs YES)

  set(doxyfile_in ${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.cmake.in)
  set(doxyfile ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)

  SET(STATIC_PAGES  ${CMAKE_CURRENT_SOURCE_DIR}/footer/oai_footer.html ${CMAKE_CURRENT_SOURCE_DIR}/header/oai_header.html)
  #SET(APIDOC_DIR    ${CMAKE_BINARY_DIR}/doc CACHE PATH "API documentation directory")

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

  IF (WIN32 AND NOT CYGWIN)
    SET(DOXYGEN_GENERATE_MAN NO)
  ENDIF (WIN32 AND NOT CYGWIN)
  
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
    DESTINATION share/doc/oai
    COMPONENT "docs"
    )
  install(FILES
    ${PROJECT_SOURCE_DIR}/openair3/DOCS/Latex/DefaultBearer/DefaultBearer.pdf
    ${PROJECT_SOURCE_DIR}/openair3/DOCS/Latex/DefaultBearer/EPC/EPC.pdf
    DESTINATION share/doc/oai
    COMPONENT "docs"
    )
#/Documentation/oaisim_mme.pdf

  #DOXYGEN_DOT_EXECUTABLE

  if(0)  
    set(DOCS_SOURCE_DIR ${PROJECT_SOURCE_DIR}/openair3/DOCS)
    add_custom_target(doxy-update
      COMMAND ${DOXYGEN_EXECUTABLE} -u
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      )
    ExternalProject_Add(ep_oai_docs
      SOURCE_DIR ${DOCS_SOURCE_DIR}
      COMMENT "OAI documents -- "
      CONFIGURE_COMMAND test -f config.status || ${DOCS_SOURCE_DIR}/configure --prefix=$(CMAKE_CURRENT_BINARY_DIR) --enable-maintainer-mode --enable-shared
      )
    ExternalProject_Add_Step(ep_oai_docs autoupdate
      DEPENDEES download
      COMMAND autoupdate --verbose
      WORKING_DIRECTORY ${DOCS_SOURCE_DIR}
      )
    ExternalProject_Add_Step(ep_oai_docs init
      DEPENDEES autoupdate
      COMMAND autoreconf --force --install --verbose --warnings=all --symlink
      COMMENT "OAI documents customised :: being autoreconfed"
      WORKING_DIRECTORY ${DOCS_SOURCE_DIR}
      BYPRODUCTS configure Makefile.in config.h.in
      )
  endif()


endif(DOXYGEN_FOUND)

