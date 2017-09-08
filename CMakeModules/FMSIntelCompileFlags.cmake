# CPP/FPP Macros
set(FMS_Fortran_CPPFLAGS
  "-DINTERNAL_FILE_NML"
  CACHE STRING "Fortran Preprocessor Flags" FORCE)
set(FMS_C_CPPFLAGS
  "-D__IFC"
  CACHE STRING "C Preprocessor Flags" FORCE)

# Fortran Compile Options
set(FMS_Fortran_FLAGS
  "-fno-alias -stack_temps -safe_cray_ptr -ftz -assume byterecl -i4 -r8 -nowarn -g -sox -traceback"
  CACHE STRING "Base Fortran compile flags for FMS" FORCE)

set(FMS_Fortran_FLAGS_PROD
  "-O2"
  CACHE STRING "Production Fortran compile flags for FMS" FORCE)

set(FMS_Fortran_FLAGS_REPRO
  "-O2 -fltconsistency"
  CACHE STRING "Reproduction Fortran compile flags for FMS" FORCE)

set(FMS_Fortran_FLAGS_DEBUG
  "-O0 -check -check noarg_temp_created -check nopointer -warn -warn noerrors -debug variable_locations -fpe0 -ftrapuv"
  CACHE STRING "Debug Fortran compile flags for FMS" FORCE)

set(FMS_Fortran_FLAGS_VERBOSE
  "-v -V -what -warn all"
  CACHE STRING "Verbosity Fortran compile flags for FMS" FORCE)

# Determine the OpenMP flag for the compiler
# Newer versions of Intel use -qopenmp
if(${CMAKE_Fortran_COMPILER_VERSION} VERSION_GREATER "15.0.0.0")
  set(OMP_Fortran_FLAGS "-qopenmp")
else(${CMAKE_Fortran_COMPILER_VERSION} VERSION_GREATER "15.0.0.0")
  set(OMP_Fortran_FLAGS "-openmp")
endif(${CMAKE_Fortran_COMPILER_VERSION} VERSION_GREATER "15.0.0.0")

set(FMS_Fortran_FLAGS_OPENMP
  ${OMP_Fortran_FLAGS}
  CACHE STRING "Fortran compile flags for OpenMP")

# C Compile Options
set(FMS_C_FLAGS
  "-sox -traceback"
  CACHE STRING "Base C compile flags for FMS" FORCE)

set(FMS_C_FLAGS_PROD
  "-O2"
  CACHE STRING "Production C compile flags for FMS" FORCE)

set(FMS_C_FLAGS_REPRO
  ""
  CACHE STRING "Reproduction C compile flags for FMS" FORCE)

set(FMS_C_FLAGS_DEBUG
  "-O0 -g -ftrapuv"
  CACHE STRING "Debug C compile flags for FMS" FORCE)

set(FMS_C_FLAGS_VERBOSE
  "-w3"
  CACHE STRING "Verbosity C compile flags for FMS" FORCE)

# Determine the OpenMP flag for the compiler
# Newer versions of Intel use -qopenmp
if(${CMAKE_C_COMPILER_VERSION} VERSION_GREATER "15.0.0.0")
  set(OMP_C_FLAGS "-qopenmp")
else(${CMAKE_C_COMPILER_VERSION} VERSION_GREATER "15.0.0.0")
  set(OMP_C_FLAGS "-openmp")
endif(${CMAKE_C_COMPILER_VERSION} VERSION_GREATER "15.0.0.0")

set(FMS_C_FLAGS_OPENMP
  ${OMP_C_FLAGS}
  CACHE STRING "C compile flags for OpenMP")
