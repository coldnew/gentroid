# - Find VIXL
#
#  This module defines the following variables:
#     VIXL_FOUND       - True if VIXL_LIBRARIES & VIXL_INCLUDE_DIRS are found
#     VIXL_LIBRARIES   - Set when VIXL_LIBRARIES is found
#     VIXL_INCLUDE_DIRS - Set when VIXL_INCLUDE_DIRS is found

# search for the android version of vixl, 
# the original version on github will probably cause file collison
find_path(VIXL_INCLUDE_DIRS NAMES platform-vixl.h
		PATH_SUFFIXES vixl
		DOC "The VIXL include directory"
)

set(VIXL_NAMES vixl 
	vixl_g
	vixl_gcov
	vixl_sim_g
	vixl_sim_gcov
	)

find_library(VIXL_LIBRARIES NAMES ${VIXL_NAMES}
		DOC "The VIXL library"
)

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(VIXL REQUIRED_VARS VIXL_LIBRARIES VIXL_INCLUDE_DIRS)
