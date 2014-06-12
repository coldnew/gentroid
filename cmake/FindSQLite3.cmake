# Try to find the SQLite librairies
# SQLITE3_FOUND - system has SQLite
# SQLITE3_LIBRARIES - Libraries needed to use SQLite

INCLUDE(FindPkgConfig)

if (SQLITE3_FIND_REQUIRED )
	set( _pkgconfig_REQUIRED "REQUIRED" )
else ()
	set( _pkgconfig_REQUIRED "" )
endif ()


pkg_search_module( SQLITE3 ${_pkgconfig_REQUIRED} sqlite3 )
if ( SQLITE3_CONFIG_FOUND )
	set ( SQLITE3_FOUND TRUE )
endif ()

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(SQLITE3 DEFAULT_MSG SQLITE3_LIBRARIES)

mark_as_advanced(SQLITE3_LIBRARIES)
