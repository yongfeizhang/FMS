# -*-cmake-*-

# Minimul version of CMake required
cmake_minimum_required (VERSION 3.7)

# Indicate where the Fortran module files should be placed during the
# build.
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

project(libfms C Fortran)

# Find custom CMake Modules
set(CMAKE_MODULE_PATH ${libfms_SOURCE_DIR}/CMakeModules ${CMAKE_MODULE_PATH})

# Include CMake modules with useful functions
include(${CMAKE_ROOT}/Modules/CheckFortranCompilerFlag.cmake)
include(${CMAKE_ROOT}/Modules/CheckCCompilerFlag.cmake)
include(${libfms_SOURCE_DIR}/CMakeModules/GetFMSCompileFlags.cmake)

# Set the default build variables
# These can be changed via `cmake -D<var>`, e.g. cmake -DOPENMP=FALSE to disable openMP.
set(OPENMP TRUE CACHE BOOL "To determine if OpenMP build should be performed")
set(BUILD_TARGET "PROD" CACHE STRING "Build Target Type.  Can be \"PROD|REPRO|DEBUG\".  Build Target of DEBUG will set CMAKE_BUILD_TYPE to DEBUG.")

# Force CMAKE_BUILD_TYPE to DEBUG if BUILD_TARGET STREQUAL DEBUG
if (BUILD_TARGET STREQUAL DEBUG)
  set(CMAKE_BUILD_TYPE "DEBUG")
else (BUILD_TARGET STREQUAL DEBUG)
  set(CMAKE_BUILD_TYPE "RELEASE" CACHE STRING "" FORCE)
endif (BUILD_TARGET STREQUAL DEBUG)

# Required external packages/libraries
find_package(NetCDF REQUIRED C Fortran)
find_package(MPI)

get_fms_compile_flags()

message("************************************************************")
message("Building FMS with")
message("Fortran Compiler: ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_Fortran_COMPILER_VERSION}")
message("Fortran Flags: ${CMAKE_Fortran_FLAGS} ${CMAKE_Fortran_FLAGS_${CMAKE_BUILD_TYPE}}")
message("C Compiler: ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_Fortran_COMPILER_VERSION}")
message("C Flags: ${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_${CMAKE_BUILD_TYPE}}")
message("Build Target: ${BUILD_TARGET}")
message("OpenMP Enabled: ${OPENMP}")
message("Using NetCDF C: ${NETCDF_C_VERSION}")
message("Using NetCDF Fortran: ${NETCDF_Fortran_VERSION}")
message("************************************************************")

# Include directory required by all
include_directories(
  ${CMAKE_CURRENT_BINARY_DIR}
  ${PROJECT_SOURCE_DIR}/include
  )

# **********************************************************************
# Source Files

add_subdirectory(constants)
add_subdirectory(platform)
add_subdirectory(tridiagonal)
add_subdirectory(mpp)
add_subdirectory(memutils)
add_subdirectory(drifters)
add_subdirectory(fms)
add_subdirectory(axis_utils)
add_subdirectory(block_control)
add_subdirectory(fft)
add_subdirectory(field_manager)
add_subdirectory(mosaic)
add_subdirectory(sat_vapor_pres)
add_subdirectory(time_manager)
add_subdirectory(tracer_manager)
add_subdirectory(astronomy)
add_subdirectory(column_diagnostics)
add_subdirectory(diag_manager)
add_subdirectory(horiz_interp)
add_subdirectory(oda_tools)
add_subdirectory(random_numbers)
add_subdirectory(time_interp)
add_subdirectory(topography)
add_subdirectory(amip_interp)
add_subdirectory(coupler)
add_subdirectory(data_override)
add_subdirectory(exchange)
add_subdirectory(interpolator)

add_library(fms
   $<TARGET_OBJECTS:constants>
   $<TARGET_OBJECTS:platform>
   $<TARGET_OBJECTS:tridiagonal>
   $<TARGET_OBJECTS:mpp>
   $<TARGET_OBJECTS:memutils>
   $<TARGET_OBJECTS:drifters>
   $<TARGET_OBJECTS:fms_mod>
   $<TARGET_OBJECTS:axis_utils>
   $<TARGET_OBJECTS:block_control>
   $<TARGET_OBJECTS:fft99>
   $<TARGET_OBJECTS:fft>
   $<TARGET_OBJECTS:field_manager>
   $<TARGET_OBJECTS:mosaic>
   $<TARGET_OBJECTS:sat_vapor_pres>
   $<TARGET_OBJECTS:time_manager>
   $<TARGET_OBJECTS:tracer_manager>
   $<TARGET_OBJECTS:astronomy>
   $<TARGET_OBJECTS:column_diagnostics>
   $<TARGET_OBJECTS:diag_manager>
   $<TARGET_OBJECTS:horiz_interp>
   $<TARGET_OBJECTS:oda_tools>
   $<TARGET_OBJECTS:random_numbers>
   $<TARGET_OBJECTS:time_interp>
   $<TARGET_OBJECTS:topography>
   $<TARGET_OBJECTS:amip_interp>
   $<TARGET_OBJECTS:coupler>
   $<TARGET_OBJECTS:data_override>
   $<TARGET_OBJECTS:exchange>
   $<TARGET_OBJECTS:interpolator>
   )
