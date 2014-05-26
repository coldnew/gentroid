# - Find MCLinker
#
#  This module defines the following variables:
#     MCLD_FOUND       - True if MCLD_LIBRARIES & MCLD_INCLUDE_DIRS are found
#     MCLD_LIBRARIES   - Set when MCLD_LIBRARIES is found
#     MCLD_INCLUDE_DIRS - Set when MCLD_INCLUDE_DIRS is found

find_path(MCLD_INCLUDE_DIRS NAMES mcld/Linker.h
          DOC "The MCLinker include directory"
)

find_library(MCLD_LIBRARIES NAMES mcld
          DOC "The MCLinker library"
)

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(MCLD REQUIRED_VARS MCLD_LIBRARIES MCLD_INCLUDE_DIRS)
