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

IF(UNIX AND NOT APPLE)

INCLUDE( FindPkgConfig )

# Take care about check.pc settings
PKG_SEARCH_MODULE( CHECK check )

# Look for CHECK include dir and libraries
IF( NOT CHECK_FOUND )
	IF ( CHECK_INSTALL_DIR )
		MESSAGE ( STATUS "Using override CHECK_INSTALL_DIR to find check" )
		SET ( CHECK_INCLUDE_DIR  "${CHECK_INSTALL_DIR}/include" )
		SET ( CHECK_INCLUDE_DIRS "${CHECK_INCLUDE_DIR}" )
		FIND_LIBRARY( CHECK_LIBRARY NAMES check PATHS "${CHECK_INSTALL_DIR}/lib" )
		FIND_LIBRARY( COMPAT_LIBRARY NAMES compat PATHS "${CHECK_INSTALL_DIR}/lib" )
		SET ( CHECK_LIBRARIES "${CHECK_LIBRARY}" "${COMPAT_LIBRARY}" )
	ELSE ( CHECK_INSTALL_DIR )
		FIND_PATH( CHECK_INCLUDE_DIR check.h )
		FIND_LIBRARY( CHECK_LIBRARIES NAMES check )
	ENDIF ( CHECK_INSTALL_DIR )

	IF ( CHECK_INCLUDE_DIR AND CHECK_LIBRARIES )
		SET( CHECK_FOUND 1 )
		IF ( NOT Check_FIND_QUIETLY )
			MESSAGE ( STATUS "Found CHECK: ${CHECK_LIBRARIES}" )
		ENDIF ( NOT Check_FIND_QUIETLY )
	ELSE ( CHECK_INCLUDE_DIR AND CHECK_LIBRARIES )
		IF ( Check_FIND_REQUIRED )
			MESSAGE( FATAL_ERROR "Could NOT find CHECK" )
		ELSE ( Check_FIND_REQUIRED )
			IF ( NOT Check_FIND_QUIETLY )
				MESSAGE( STATUS "Could NOT find CHECK" )	
			ENDIF ( NOT Check_FIND_QUIETLY )
		ENDIF ( Check_FIND_REQUIRED )
	ENDIF ( CHECK_INCLUDE_DIR AND CHECK_LIBRARIES )
ENDIF( NOT CHECK_FOUND )

# Hide advanced variables from CMake GUIs
MARK_AS_ADVANCED( CHECK_INCLUDE_DIR CHECK_LIBRARIES )

ENDIF(UNIX AND NOT APPLE)
