# Try to find the Valgrind librairies
# VALGRIND_FOUND - system has Valgrind lib
# VALGRIND_INCLUDE_DIR - the Valgrind include directory
# VALGRIND_LIBRARIES - Libraries needed to use Valgrind

if (VALGRIND_INCLUDE_DIRS AND VALGRIND_LIBRARIES)
	# Already in cache, be silent
	set(VALGRIND_FIND_QUIETLY TRUE)
endif ()

INCLUDE(FindPkgConfig)

IF ( VALGRIND_FIND_REQUIRED )
	SET( _pkgconfig_REQUIRED "REQUIRED" )
ELSE ()
	SET( _pkgconfig_REQUIRED "" )
ENDIF ()


PKG_SEARCH_MODULE( VALGRIND ${_pkgconfig_REQUIRED} valgrind )
IF ( PKG_CONFIG_FOUND )
SET ( VALGRIND_FOUND TRUE )
ENDIF ()


include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(VALGRIND DEFAULT_MSG VALGRIND_INCLUDE_DIRS VALGRIND_LIBRARIES)

mark_as_advanced(VALGRIND_INCLUDE_DIRS VALGRIND_LIBRARIES)
