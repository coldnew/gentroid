# - Try to find the Skia libraries
# Once done this will define
#
#  SKIA_FOUND 				- system has Skia
#  SKIA_<COMPONENT>_FOUND 	- TRUE if <component> is found.
#  SKIA_INCLUDE_DIRS 		- the Skia include directories
#  SKIA_LIBRARIES 			- Libraries needed to use Skia
#  SKIA_CFLAGS	 			

if (NOT SKIA_ROOT)
	set (SKIA_ROOT /usr)
endif ()


find_path (SKIA_INCLUDE_DIRS NAMES GLES2/gl2.h)

find_library (SKIA_LIBRARIES NAMES skia)

if (SKIA_LIBRARIES)
	find_library (SKIA_EXTRA_LIBRARIES NAMES skia_extra)
	if (SKIA_EXTRA_LIBRARIES)
		set (SKIA_LIBRARIES ${SKIA_LIBRARIES} ${SKIA_EXTRA_LIBRARIES})
	else ()
		set (SKIA_LIBRARIES 0)
	endif ()
endif ()



function (_find_skia_incdirs)
	set (SKIA_INCLUDE_DIR ${SKIA_ROOT}/include/skia)
	set (SKIA_INCLUDE_DIRS ${SKIA_INCLUDE_DIR})
	
	set (SKIA_SEARCH_DIRS core config ports animator effects images pdf gpu utils views xml)	

	foreach (_inc ${SKIA_SEARCH_DIRS})
		if (EXISTS ${SKIA_INCLUDE_DIR}/${_inc})
			list (APPEND SKIA_INCLUDE_DIRS ${SKIA_INCLUDE_DIR}/${_inc})
		else ()
			set (SKIA_INCLUDE_DIRS false PARENT_SCOPE)
			return ()
		endif ()
	endforeach () 

	#set global
	set (SKIA_INCLUDE_DIRS ${SKIA_INCLUDE_DIRS} PARENT_SCOPE)
endfunction ()

_find_skia_incdirs ()   

set (SKIA_CFLAGS -DSK_ATOMICS_PLATFORM_H="SkAtomics_sync.h" -DSK_MUTEX_PLATFORM_H="SkMutex_pthread.h" -D SK_SUPPORT_LEGACY_SETCONFIG_INFO
		-D SK_SUPPORT_LEGACY_DEVICE_CONFIG -D SK_SUPPORT_LEGACY_SETCONFIG -D SK_SUPPORT_LEGACY_CLIPTOLAYERFLAG
    	-D SK_ATTR_DEPRECATED=SK_NOTHING_ARG1 -D SK_SUPPORT_LEGACY_SHADER_LOCALMATRIX -D SK_SUPPORT_LEGACY_COMPUTE_CONFIG_SIZE 
		-D SK_SUPPORT_LEGACY_ASIMAGEINFO -D SK_SUPPORT_LEGACY_LAYERRASTERIZER_API -D SK_SUPPORT_DEPRECATED_SCALARROUND -D SK_SUPPORT_LEGACY_BITMAP_CONFIG
		-D SK_SUPPORT_LEGACY_DEFAULT_PICTURE_CTOR -D SK_SUPPORT_LEGACY_PICTURE_CLONE
		-D SK_BUILD_FOR_GENTROID -D SK_RELEASE)

if (${CMAKE_SYSTEM_PROCESSOR} MATCHES "x86_64" OR ${CMAKE_SYSTEM_PROCESSOR} MATCHES "x86")
	list (APPEND SKIA_CFLAGS -DSK_BARRIERS_PLATFORM_H="SkBarriers_x86.h")
elseif (${CMAKE_SYSTEM_PROCESSOR} MATCHES "arm")
	list (APPEND SKIA_CFLAGS -DSK_BARRIERS_PLATFORM_H="SkBarriers_arm.h")
else ()
	message (FATAL_ERROR "\"${CMAKE_SYSTEM_PROCESSOR}\" is unsupported")
endif ()

include (FindPackageHandleStandardArgs)
find_package_handle_standard_args (Skia REQUIRED_VARS SKIA_INCLUDE_DIRS SKIA_LIBRARIES)




