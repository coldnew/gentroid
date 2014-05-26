# Try to find the unwind librairies
# UNWIND_FOUND - system has libunwind
# UNWIND_INCLUDE_DIR - the unwind include directory
# UNWIND_LIBRARIES - Libraries needed to use libunwind

if (UNWIND_INCLUDE_DIRS AND UNWIND_LIBRARIES)
	# Already in cache, be silent
	set(UNWIND_FIND_QUIETLY TRUE)
endif ()

INCLUDE(FindPkgConfig)

IF (UNWIND_FIND_REQUIRED )
	SET( _pkgconfig_REQUIRED "REQUIRED" )
ELSE ()
	SET( _pkgconfig_REQUIRED "" )
ENDIF ()


PKG_SEARCH_MODULE( UNWIND ${_pkgconfig_REQUIRED} libunwind )
IF ( UNWIND_CONFIG_FOUND )
SET ( UNWIND_FOUND TRUE )
ENDIF ()

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(UNWIND DEFAULT_MSG UNWIND_INCLUDE_DIRS UNWIND_LIBRARIES UNWIND_LIBRARY_DIRS)

mark_as_advanced(UNWIND_INCLUDE_DIRS UNWIND_LIBRARIES UNWIND_LIBRARY_DIRS)
