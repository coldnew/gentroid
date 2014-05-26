# - Try to find the Android framework
# Once done this will define
#
#  ANDROID_FOUND 				- system has Android
#  ANDROID_<COMPONENT>_FOUND 	- TRUE if <component> is found.
#  ANDROID_INCLUDE_DIRS 			- the Android include directories
#  ANDROID_LIBRARIES 			- Libraries needed to use Android

include(FindPackageHandleStandardArgs)

function (_check_android_components)
	# List of the valid Android components
	set(ANDROID_VALID_COMPONENTS
		javacore
		nativehelper
		syscore
		fdm
	)

	if(Android_FIND_COMPONENTS)
    set (_REQ_COMPONENTS ${Android_FIND_COMPONENTS})
    #respect component order in ANDROID_VALID_COMPONENTS
		foreach(_component ${ANDROID_VALID_COMPONENTS})
			list(FIND Android_FIND_COMPONENTS ${_component} _cl)
			if(NOT ${_cl} EQUAL -1)
				list(APPEND _COMPONENT_LIST ${_component})
        list(REMOVE_ITEM _REQ_COMPONENTS ${_component})
			endif()
		endforeach()
      if(_REQ_COMPONENTS)
        message( FATAL_ERROR "\"${_REQ_COMPONENTS}\" is not a valid Android component.")
	endif()
	endif()
	list(APPEND _COMPONENT_LIST 0 minimal)
	#for FIND_PACKAGE_HANDLE_STANDARD_ARGS
	set(Android_FIND_COMPONENTS ${_COMPONENT_LIST} PARENT_SCOPE)
endfunction()

function (_find_android_libraries)
	set(minimal_LIBS utils 
		cutils
		log)	

	set(syscore_LIBS ziparchive
		backtrace)

	set(nativehelper_LIBS
		nativehelper)

	set(fdm_LIBS
		fdm)

	set(javacore_LIBS
		javacore)

	foreach(_component ${Android_FIND_COMPONENTS})
		set(ANDROID_${_component}_FOUND true)
		foreach(_lib ${${_component}_LIBS})
			find_library(_tmplib NAMES ${_lib} lib${_lib}
					HINTS ${ANDROID_ROOT}/lib${LIB_SUFFIX}/android)
			if(${_tmplib} MATCHES NOTFOUND)
				set(ANDROID_${_component}_FOUND false)
			else()
				list(APPEND ANDROID_LIBRARIES ${_tmplib})
			endif()
			unset(_tmplib CACHE)
		endforeach()
		#set both variants lower case and upper case
		set(Android_${_component}_FOUND ${ANDROID_${_component}_FOUND} PARENT_SCOPE)
		set(ANDROID_${_component}_FOUND ${ANDROID_${_component}_FOUND} PARENT_SCOPE)
		
	endforeach() 
	#set global
	set(ANDROID_LIBRARIES ${ANDROID_LIBRARIES} PARENT_SCOPE)
endfunction()


function (_find_android_incdirs)
	set(ANDROID_INCLUDE_DIR ${ANDROID_ROOT}/include/android)
	set(ANDROID_INCLUDE_DIRS ${ANDROID_INCLUDE_DIR})
	
	set(nativehelper_INC nativehelper)	
	set(javacore_INC javacore)

	foreach(_component ${Android_FIND_COMPONENTS})
		if(${_component}_INC)
			foreach(_inc ${${_component}_INC})
				if(EXISTS ${ANDROID_INCLUDE_DIR}/${_inc})
					list(APPEND ANDROID_INCLUDE_DIRS ${ANDROID_INCLUDE_DIR}/${_inc})
				endif()
			endforeach()
		endif()
	endforeach() 

	#set global
	set(ANDROID_INCLUDE_DIRS ${ANDROID_INCLUDE_DIRS} PARENT_SCOPE)
endfunction()

_check_android_components()   
_find_android_libraries()    
_find_android_incdirs()   


FIND_PACKAGE_HANDLE_STANDARD_ARGS(Android
                                  REQUIRED_VARS ANDROID_INCLUDE_DIRS ANDROID_LIBRARIES
                                  HANDLE_COMPONENTS)




