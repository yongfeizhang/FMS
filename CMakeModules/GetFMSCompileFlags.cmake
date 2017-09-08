# Distributed with the Flexible Modeling System source code
# Author: Seth Underwood

#.rst
# GetFMSCompileFlags
# ------------------
#
# Return the possible compiler options to compile the FMS
# source.
#
# Functions
# ^^^^^^^^^
#
# This module has the following functions
#
# ::
#
#     get_fms_compile_flags   Get the correct Fortran and C compiler flags for the compiler family
#
# Variables
# ^^^^^^^^^
#
# This module will set the following variables per language in your
# project, where <lang> is one of C or Fortran
#
# ::
#
#    FMS_<lang>_FLAGS          Base compiler flags for all targets
#    FMS_<lang>_FLAGS_PROD     Compiler flags for production compile targets
#    FMS_<lang>_FLAGS_REPRO    Compiler flags for reproduction compile target
#    FMS_<lang>_FLAGS_DEBUG    Compiler flags for debug compile target
#    FMS_<lang>_FLAGS_VERBOSE  Compiler flags for VERBOSE output
#    FMS_<lang>_FLAGS_OPENMP   Flags to compile with OpenMP thread support
#    FMS_<lang>_CPPFLAGS       CPP/FPP macro flags
#
# Usage
# ^^^^^
#
# To use this module, call GetFMSCompileFlags from a CMakeLists.txt.
# Once the above variables are set, set CMAKE_<lang>_FLAGS in the
# CMakeLists.txt with code similar to:
#
# set(CMAKE_<lang>_FLAGS ${FMS_<lang>_FLAGS} CACHE STRING "Default <lang> compiler options" FORCE)
# set(CMAKE_<lang>_FLAGS_DEBUG ${FMS_<lang>_FLAGS_DEBUG CACHE STRING "Default <lang> debug compiler options" FORCE)
# set(CMAKE_<lang>_FLAGS_RELEASE ${FMS_<lang>_FLAGS_<PROD|REPRO> CACHE STRING "Compiler options for <PROD|REPRO>" FORCE)

function(GET_FMS_COMPILE_FLAGS)
  if(NOT "${CMAKE_Fortran_COMPILER_ID}" STREQUAL "${CMAKE_C_COMPILER_ID}")
    message(FATAL_ERROR "The Fortran and C compilers must be the same family")
  endif(NOT "${CMAKE_Fortran_COMPILER_ID}" STREQUAL "${CMAKE_C_COMPILER_ID}")

  # Get the compiler flags for the given family
  include(${CMAKE_CURRENT_LIST_DIR}/CMakeModules/FMS${CMAKE_C_COMPILER_ID}CompileFlags.cmake)

  # Set the default list of compiler options (Including OpenMP)
  if(${OPENMP})
    set(CMAKE_Fortran_FLAGS "${FMS_Fortran_FLAGS} ${FMS_Fortran_FLAGS_OPENMP}" CACHE STRING "Default Fortran compile flags" FORCE)
    set(CMAKE_C_FLAGS "${FMS_C_FLAGS} ${FMS_C_FLAGS_OPENMP}" CACHE STRING "Default C compile flags" FORCE)
  else(${OPENMP})
    set(CMAKE_Fortran_FLAGS "${FMS_Fortran_FLAGS}" CACHE STRING "Default Fortran compile flags" FORCE)
    set(CMAKE_C_FLAGS "${FMS_C_FLAGS}" CACHE STRING "Default C compile flags" FORCE)
  endif(${OPENMP})
  
  set(CMAKE_Fortran_FLAGS_RELEASE "${FMS_Fortran_FLAGS_${BUILD_TARGET}}" CACHE STRING "Release Fortran compile flags" FORCE)
  set(CMAKE_C_FLAGS_RELEASE "${FMS_C_FLAGS_${BUILD_TARGET}}" CACHE STRING "Release C compile flags" FORCE)

  set(CMAKE_Fortran_FLAGS_DEBUG "${FMS_Fortran_FLAGS_DEBUG}" CACHE STRING "Debug Fortran compile flags" FORCE)
  set(CMAKE_C_FLAGS_DEBUG "${FMS_C_FLAGS_DEBUG}" CACHE STRING "Debug C compile flags" FORCE)

  add_definitions(${FMS_Fortran_CPPFLAGS} ${FMS_C_CPPFLAGS})

  # Expand _FILE_VERSION to include the git information
  # Cmake policy CMP0005 has add_definitions automatically escape
  # strings, which causes issue with using git-version-string as
  # we like to get the git object has of each source file.  Using
  # the old policy gets past this.  Then after the definition is added
  # revert to the NEW policy.
  #
  # TODO - protect in the case that git-version-string is not in the path.
  #        If git-version-string is not in the path, then either set
  #        _FILE_VERSION to "UNKNOWN", or run some other git command to get
  #        another hash.  Another option is to add git-version-string to the
  #        repository.
  cmake_policy(SET CMP0005 OLD)
  add_definitions(-D_FILE_VERSION="`git-version-string $<`")
  cmake_policy(SET CMP0005 NEW)
endfunction(GET_FMS_COMPILE_FLAGS)
