# - Try to find the Skia libraries
# Once done this will define
#
#  SKIA_FOUND 				- system has Skia
#  SKIA_<COMPONENT>_FOUND 	- TRUE if <component> is found.
#  SKIA_INCLUDE_DIRS 		- the Skia include directories
#  SKIA_LIBRARIES 			- Libraries needed to use Skia
#  SKIA_CFLAGS	 			

if (NOT SKIA_ROOT)
	set(SKIA_ROOT /usr)
endif()

function (_check_skia_components)
	# List of the valid Skia components
	set(SKIA_VALID_COMPONENTS
		animator
		effects
		images
		opts
		pdf
		ports
		sfnt
		gpu
		utils
		views
		xml)

	if(Skia_FIND_COMPONENTS)
    set (_REQ_COMPONENTS ${Skia_FIND_COMPONENTS})
    #respect component order in SKIA_VALID_COMPONENTS
		foreach(_component ${SKIA_VALID_COMPONENTS})
			list(FIND Skia_FIND_COMPONENTS ${_component} _cl)
			if(NOT ${_cl} EQUAL -1)
				list(APPEND _COMPONENT_LIST ${_component})
        		list(REMOVE_ITEM _REQ_COMPONENTS ${_component})
			endif()
		endforeach()
      if(_REQ_COMPONENTS)
        message( FATAL_ERROR "\"${_REQ_COMPONENTS}\" is not a valid Skia component.")
	endif()
	endif()
	list(APPEND _COMPONENT_LIST 0 core)
	#for FIND_PACKAGE_HANDLE_STANDARD_ARGS
	set(Skia_FIND_COMPONENTS ${_COMPONENT_LIST} PARENT_SCOPE)
endfunction()

function (_find_skia_libraries)
	set(core_LIBS core)	
	set(animator_LIBS animator)	
	set(effects_LIBS effects)
	set(images_LIBS images)
	#should be platform independent
	set(opts_LIBS opts)
	set(pdf_LIBS pdf)
	set(ports_LIBS ports)
	set(sfnt_LIBS sfnt)
	set(gpu_LIBS gpu)
	set(utils_LIBS utils)
	set(views_LIBS views)
	set(xml_LIBS xml)

	foreach(_component ${Skia_FIND_COMPONENTS})
		set(SKIA_${_component}_FOUND true)
		foreach(_lib ${${_component}_LIBS})
			find_library(_tmplib NAMES skia_${_lib} libskia_${_lib}
					HINTS ${SKIA_ROOT}/lib${LIB_SUFFIX})
			if(${_tmplib} MATCHES NOTFOUND)
				set(SKIA_${_component}_FOUND false)
			else()
				list(APPEND SKIA_LIBRARIES ${_tmplib})
			endif()
			unset(_tmplib CACHE)
		endforeach()
		#set both variants lower case and upper case
		set(Skia_${_component}_FOUND ${SKIA_${_component}_FOUND} PARENT_SCOPE)
		set(SKIA_${_component}_FOUND ${SKIA_${_component}_FOUND} PARENT_SCOPE)
	endforeach() 
	#set global
	set(SKIA_LIBRARIES ${SKIA_LIBRARIES} PARENT_SCOPE)
endfunction()


function (_find_skia_incdirs)
	set(SKIA_INCLUDE_DIR ${SKIA_ROOT}/include/skia)
	set(SKIA_INCLUDE_DIRS ${SKIA_INCLUDE_DIR})
	
	set(core_INC core config ports)	
	set(animator_INC animator)	
	set(effects_INC effects)
	set(images_INC images)
	set(pdf_INC pdf)
	set(gpu_INC gpu)
	set(utils_INC utils)
	set(views_INC views)
	set(xml_INC xml)

	foreach(_component ${Skia_FIND_COMPONENTS})
		if(${_component}_INC)
			foreach(_inc ${${_component}_INC})
				if(EXISTS ${SKIA_INCLUDE_DIR}/${_inc})
					list(APPEND SKIA_INCLUDE_DIRS ${SKIA_INCLUDE_DIR}/${_inc})
				endif()
			endforeach()
		endif()
	endforeach() 

	#set global
	set(SKIA_INCLUDE_DIRS ${SKIA_INCLUDE_DIRS} PARENT_SCOPE)
endfunction()



_check_skia_components()   
_find_skia_libraries()    
_find_skia_incdirs()   

set(SKIA_CFLAGS -DSK_ATOMICS_PLATFORM_H="SkAtomics_sync.h" -DSK_MUTEX_PLATFORM_H="SkMutex_pthread.h")

if (${CMAKE_SYSTEM_PROCESSOR} MATCHES "x86_64" OR ${CMAKE_SYSTEM_PROCESSOR} MATCHES "x86")
	list(APPEND SKIA_CFLAGS -DSK_BARRIERS_PLATFORM_H="SkBarriers_x86.h")
elseif (${CMAKE_SYSTEM_PROCESSOR} MATCHES "arm")
	list(APPEND SKIA_CFLAGS -DSK_BARRIERS_PLATFORM_H="SkBarriers_arm.h")
else()
	message( FATAL_ERROR "\"${CMAKE_SYSTEM_PROCESSOR}\" is unsupported")
endif()

include(FindPackageHandleStandardArgs)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(Skia
                                  REQUIRED_VARS SKIA_INCLUDE_DIRS SKIA_LIBRARIES
                                  HANDLE_COMPONENTS)




