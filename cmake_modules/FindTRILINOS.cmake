#
# Trilinos
#
# Looks for Trilinos packages
#
# Required packages are:
# - Epetra, Teuchos
#

# You can specify your own version of the library
# by specifying the variables TRILINOS_LIB_SEARCH_PATH and
# TRILINOS_INCLUDE_SEARCH_PATH.
IF (NOT TRILINOS_LIBRARY_DIR OR NOT TRILINOS_INCLUDE_DIR)
    IF (TRILINOS_ROOT)
        # Alternatively, you may simply specify TRILINOS_ROOT in CMake.vars. This is
        # the traditional way used also in the spkg files from the hpfem/solvers
        # repository and in the Hermes spkg.
        SET(TRILINOS_LIB_SEARCH_PATH ${TRILINOS_ROOT}/lib)
        SET(TRILINOS_INCLUDE_SEARCH_PATH ${TRILINOS_ROOT}/include)
    ELSE (TRILINOS_ROOT)
        SET(TRILINOS_LIB_SEARCH_PATH
            /usr/lib64
            /usr/lib
            /usr/local/lib/
            /usr/lib/x86_64-linux-gnu/
        )
        SET(TRILINOS_INCLUDE_SEARCH_PATH
            /usr/include
            /usr/local/include/
            /usr/include/trilinos/
        )
    ENDIF (TRILINOS_ROOT)
ELSE (NOT TRILINOS_LIBRARY_DIR OR NOT TRILINOS_INCLUDE_DIR)
    SET(TRILINOS_LIB_SEARCH_PATH ${TRILINOS_LIBRARY_DIR})
    SET(TRILINOS_INCLUDE_SEARCH_PATH ${TRILINOS_INCLUDE_DIR})
ENDIF (NOT TRILINOS_LIBRARY_DIR OR NOT TRILINOS_INCLUDE_DIR)


FIND_PATH(AMESOS_INCLUDE_PATH       Amesos.h             ${TRILINOS_INCLUDE_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_PATH(AMESOS2_INCLUDE_PATH      Amesos2.hpp          ${TRILINOS_INCLUDE_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_PATH(AZTECOO_INCLUDE_PATH      AztecOO.h            ${TRILINOS_INCLUDE_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_PATH(EPETRA_INCLUDE_PATH       Epetra_Object.h      ${TRILINOS_INCLUDE_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_PATH(IFPACK_INCLUDE_PATH       Ifpack.h             ${TRILINOS_INCLUDE_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_PATH(LOCA_INCLUDE_PATH         LOCA.H               ${TRILINOS_INCLUDE_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_PATH(ML_INCLUDE_PATH           MLAPI.h              ${TRILINOS_INCLUDE_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_PATH(NOX_INCLUDE_PATH          NOX.H                ${TRILINOS_INCLUDE_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_PATH(TEUCHOS_INCLUDE_PATH      Teuchos_Object.hpp   ${TRILINOS_INCLUDE_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_PATH(TRIUTILS_INCLUDE_PATH      Triutils_config.h   ${TRILINOS_INCLUDE_SEARCH_PATH}  NO_DEFAULT_PATH)

FIND_PATH(LOCA_EPETRA_INCLUDE_PATH  LOCA_Epetra.H        ${TRILINOS_INCLUDE_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_PATH(NOX_EPETRA_INCLUDE_PATH   NOX_Epetra.H         ${TRILINOS_INCLUDE_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_PATH(EPETRAEXT_INCLUDE_PATH    EpetraExt_Version.h  ${TRILINOS_INCLUDE_SEARCH_PATH}  NO_DEFAULT_PATH)

FIND_LIBRARY(AMESOS_LIBRARY         "${TRILINOS_LIBRARY_PREFIX}amesos"           ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_LIBRARY(AMESOS2_LIBRARY        "${TRILINOS_LIBRARY_PREFIX}amesos2"          ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_LIBRARY(AZTECOO_LIBRARY        "${TRILINOS_LIBRARY_PREFIX}aztecoo"          ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_LIBRARY(EPETRA_LIBRARY         "${TRILINOS_LIBRARY_PREFIX}epetra"           ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
IF(NOT EPETRA_LIBRARY)
    FIND_LIBRARY(EPETRA_LIBRARY         "${TRILINOS_LIBRARY_PREFIX}epetra.so"           ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
ENDIF(NOT EPETRA_LIBRARY)
FIND_LIBRARY(IFPACK_LIBRARY         "${TRILINOS_LIBRARY_PREFIX}ifpack"           ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_LIBRARY(LOCA_LIBRARY           "${TRILINOS_LIBRARY_PREFIX}loca"             ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_LIBRARY(ML_LIBRARY             "${TRILINOS_LIBRARY_PREFIX}ml"               ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_LIBRARY(NOX_LIBRARY            "${TRILINOS_LIBRARY_PREFIX}nox"            ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_LIBRARY(TEUCHOS_LIBRARY        "${TRILINOS_LIBRARY_PREFIX}teuchos"           ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
IF(NOT TEUCHOS_LIBRARY)
    FIND_LIBRARY(TEUCHOSCOMM_LIBRARY            "${TRILINOS_LIBRARY_PREFIX}teuchoscomm"      ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
    IF(NOT TEUCHOSCOMM_LIBRARY)
        FIND_LIBRARY(TEUCHOSCOMM_LIBRARY         "${TRILINOS_LIBRARY_PREFIX}teuchoscomm.so"           ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
    ENDIF(NOT TEUCHOSCOMM_LIBRARY)
    FIND_LIBRARY(TEUCHOSCORE_LIBRARY            "${TRILINOS_LIBRARY_PREFIX}teuchoscore"       ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
    IF(NOT TEUCHOSCORE_LIBRARY)
        FIND_LIBRARY(TEUCHOSCORE_LIBRARY         "${TRILINOS_LIBRARY_PREFIX}teuchoscore.so"           ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
    ENDIF(NOT TEUCHOSCORE_LIBRARY)
    FIND_LIBRARY(TEUCHOSNUMERICS_LIBRARY        "${TRILINOS_LIBRARY_PREFIX}teuchosnumerics"   ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
    IF(NOT TEUCHOSNUMERICS_LIBRARY)
        FIND_LIBRARY(TEUCHOSNUMERICS_LIBRARY         "${TRILINOS_LIBRARY_PREFIX}teuchosnumerics.so"           ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
    ENDIF(NOT TEUCHOSNUMERICS_LIBRARY)
    FIND_LIBRARY(TEUCHOSPARAMETERLIST_LIBRARY   "${TRILINOS_LIBRARY_PREFIX}teuchosparameterlist" ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
    IF(NOT TEUCHOSPARAMETERLIST_LIBRARY)
        FIND_LIBRARY(TEUCHOSPARAMETERLIST_LIBRARY         "${TRILINOS_LIBRARY_PREFIX}teuchosparameterlist.so"           ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
    ENDIF(NOT TEUCHOSPARAMETERLIST_LIBRARY)
    FIND_LIBRARY(TEUCHOSREMAINDER_LIBRARY       "${TRILINOS_LIBRARY_PREFIX}teuchosremainder"    ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
    IF(NOT TEUCHOSREMAINDER_LIBRARY)
        FIND_LIBRARY(TEUCHOSREMAINDER_LIBRARY         "${TRILINOS_LIBRARY_PREFIX}teuchosremainder.so"           ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
    ENDIF(NOT TEUCHOSREMAINDER_LIBRARY)
ENDIF(NOT TEUCHOS_LIBRARY)

FIND_LIBRARY(TRIUTILS_LIBRARY       "${TRILINOS_LIBRARY_PREFIX}triutils"          ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
IF(NOT TRIUTILS_LIBRARY)
    FIND_LIBRARY(TRIUTILS_LIBRARY         "${TRILINOS_LIBRARY_PREFIX}triutils.so"           ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
ENDIF(NOT TRIUTILS_LIBRARY)

FIND_LIBRARY(LOCA_EPETRA_LIBRARY    "${TRILINOS_LIBRARY_PREFIX}locaepetra"         ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_LIBRARY(NOX_EPETRA_LIBRARY     "${TRILINOS_LIBRARY_PREFIX}noxepetra"         ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_LIBRARY(EPETRAEXT_LIBRARY      "${TRILINOS_LIBRARY_PREFIX}epetraext"          ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)



IF(TEUCHOS_LIBRARY)
	SET(TEUCHOS_LIBRARIES "${TEUCHOS_LIBRARY}")
ELSEIF(TEUCHOSCOMM_LIBRARY AND TEUCHOSCORE_LIBRARY AND TEUCHOSNUMERICS_LIBRARY AND TEUCHOSPARAMETERLIST_LIBRARY AND TEUCHOSREMAINDER_LIBRARY)
	SET(TEUCHOS_LIBRARIES ${TEUCHOSCOMM_LIBRARY} ${TEUCHOSCORE_LIBRARY} ${TEUCHOSNUMERICS_LIBRARY} ${TEUCHOSPARAMETERLIST_LIBRARY} ${TEUCHOSREMAINDER_LIBRARY})
ELSE(TEUCHOS_LIBRARY)
	SET(TEUCHOS_LIBRARIES "")
ENDIF(TEUCHOS_LIBRARY)

FIND_PATH(ZOLTAN_INCLUDE_PATH       zoltan.h             ${TRILINOS_INCLUDE_SEARCH_PATH}  NO_DEFAULT_PATH)
FIND_LIBRARY(ZOLTAN_LIBRARY         "${TRILINOS_LIBRARY_PREFIX}zoltan"              ${TRILINOS_LIB_SEARCH_PATH}  NO_DEFAULT_PATH)

INCLUDE(FindPackageHandleStandardArgs)

message("EPETRA_INCLUDE_PATH: " ${EPETRA_INCLUDE_PATH})
message("EPETRA_LIBRARY: " ${EPETRA_LIBRARY})

IF(EPETRA_INCLUDE_PATH AND EPETRA_LIBRARY)
	SET(TRILINOS_INCLUDE_DIR ${TRILINOS_INCLUDE_DIR} ${EPETRA_INCLUDE_PATH})
	SET(TRILINOS_LIBRARIES ${TRILINOS_LIBRARIES} ${EPETRA_LIBRARY})
	SET(HAVE_EPETRA YES)
ENDIF(EPETRA_INCLUDE_PATH AND EPETRA_LIBRARY)
find_package_handle_standard_args(EPETRA DEFAULT_MSG EPETRA_LIBRARY)

message("TEUCHOS_INCLUDE_PATH: " ${TEUCHOS_INCLUDE_PATH})
message("TEUCHOS_LIBRARIES: " ${TEUCHOS_LIBRARIES})
IF(TEUCHOS_INCLUDE_PATH AND TEUCHOS_LIBRARIES)
	SET(TRILINOS_INCLUDE_DIR ${TRILINOS_INCLUDE_DIR} ${TEUCHOS_INCLUDE_PATH})
	SET(TRILINOS_LIBRARIES ${TRILINOS_LIBRARIES} ${TEUCHOS_LIBRARIES})
	SET(HAVE_TEUCHOS YES)
ENDIF(TEUCHOS_INCLUDE_PATH AND TEUCHOS_LIBRARIES)

IF(TEUCHOS_LIBRARY)
	find_package_handle_standard_args(TEUCHOS      DEFAULT_MSG    TEUCHOS_LIBRARY)
ELSEIF(TEUCHOSCOMM_LIBRARY AND TEUCHOSCORE_LIBRARY AND TEUCHOSNUMERICS_LIBRARY AND TEUCHOSPARAMETERLIST_LIBRARY AND TEUCHOSREMAINDER_LIBRARY)
	find_package_handle_standard_args(TEUCHOS      DEFAULT_MSG    TEUCHOSCOMM_LIBRARY TEUCHOSCORE_LIBRARY TEUCHOSNUMERICS_LIBRARY TEUCHOSPARAMETERLIST_LIBRARY TEUCHOSREMAINDER_LIBRARY)
ENDIF()

IF(TRIUTILS_INCLUDE_PATH AND TRIUTILS_LIBRARY)
	SET(TRILINOS_INCLUDE_DIR ${TRILINOS_INCLUDE_DIR} ${TRIUTILS_INCLUDE_PATH})
	SET(TRILINOS_LIBRARIES ${TRILINOS_LIBRARIES} ${TRIUTILS_LIBRARY})
	SET(HAVE_TRIUTILS YES)
ENDIF(TRIUTILS_INCLUDE_PATH AND TRIUTILS_LIBRARY)
find_package_handle_standard_args(TRIUTILS DEFAULT_MSG TRIUTILS_LIBRARY)

IF(AMESOS_INCLUDE_PATH AND AMESOS_LIBRARY)
	SET(TRILINOS_INCLUDE_DIR ${TRILINOS_INCLUDE_DIR} ${AMESOS_INCLUDE_PATH})
	SET(TRILINOS_LIBRARIES ${TRILINOS_LIBRARIES} ${AMESOS_LIBRARY})
	SET(HAVE_AMESOS YES)
	find_package_handle_standard_args(AMESOS DEFAULT_MSG AMESOS_LIBRARY)
ENDIF(AMESOS_INCLUDE_PATH AND AMESOS_LIBRARY)

IF(AMESOS2_INCLUDE_PATH AND AMESOS2_LIBRARY)
	SET(TRILINOS_INCLUDE_DIR ${TRILINOS_INCLUDE_DIR} ${AMESOS2_INCLUDE_PATH})
	SET(TRILINOS_LIBRARIES ${TRILINOS_LIBRARIES} ${AMESOS2_LIBRARY})
	SET(HAVE_AMESOS2 YES)
	find_package_handle_standard_args(AMESOS2 DEFAULT_MSG AMESOS2_LIBRARY)
ENDIF(AMESOS2_INCLUDE_PATH AND AMESOS2_LIBRARY)

IF(AZTECOO_INCLUDE_PATH AND AZTECOO_LIBRARY)
	SET(TRILINOS_INCLUDE_DIR ${TRILINOS_INCLUDE_DIR} ${AZTECOO_INCLUDE_PATH})
	SET(TRILINOS_LIBRARIES ${TRILINOS_LIBRARIES} ${AZTECOO_LIBRARY})
	SET(HAVE_AZTECOO YES)
	find_package_handle_standard_args(AZTECOO DEFAULT_MSG AZTECOO_LIBRARY)
ENDIF(AZTECOO_INCLUDE_PATH AND AZTECOO_LIBRARY)

IF(IFPACK_INCLUDE_PATH AND IFPACK_LIBRARY)
	SET(TRILINOS_INCLUDE_DIR ${TRILINOS_INCLUDE_DIR} ${IFPACK_INCLUDE_PATH})
	SET(TRILINOS_LIBRARIES ${TRILINOS_LIBRARIES} ${IFPACK_LIBRARY})
	SET(HAVE_IFPACK YES)
	find_package_handle_standard_args(IFPACK DEFAULT_MSG IFPACK_LIBRARY)
ENDIF(IFPACK_INCLUDE_PATH AND IFPACK_LIBRARY)

IF(LOCA_INCLUDE_PATH AND LOCA_LIBRARY)
	SET(TRILINOS_INCLUDE_DIR ${TRILINOS_INCLUDE_DIR} ${LOCA_INCLUDE_PATH})
	SET(TRILINOS_LIBRARIES ${TRILINOS_LIBRARIES} ${LOCA_LIBRARY})
	SET(HAVE_LOCA YES)
	find_package_handle_standard_args(LOCA DEFAULT_MSG LOCA_LIBRARY)
ENDIF(LOCA_INCLUDE_PATH AND LOCA_LIBRARY)

IF(ML_INCLUDE_PATH AND ML_LIBRARY)
	SET(TRILINOS_INCLUDE_DIR ${TRILINOS_INCLUDE_DIR} ${ML_INCLUDE_PATH})
	SET(TRILINOS_LIBRARIES ${TRILINOS_LIBRARIES} ${ML_LIBRARY})
	SET(HAVE_ML YES)
	find_package_handle_standard_args(ML DEFAULT_MSG ML_LIBRARY)
ENDIF(ML_INCLUDE_PATH AND ML_LIBRARY)

IF(NOX_INCLUDE_PATH AND NOX_LIBRARY AND NOX_EPETRA_INCLUDE_PATH AND NOX_EPETRA_LIBRARY)
	SET(TRILINOS_INCLUDE_DIR ${TRILINOS_INCLUDE_DIR} ${NOX_INCLUDE_PATH} ${NOX_EPETRA_INCLUDE_PATH})
	SET(TRILINOS_LIBRARIES ${TRILINOS_LIBRARIES} ${NOX_LIBRARY} ${NOX_EPETRA_LIBRARY})
	SET(HAVE_NOX YES)
	find_package_handle_standard_args(NOX DEFAULT_MSG NOX_LIBRARY)
ENDIF(NOX_INCLUDE_PATH AND NOX_LIBRARY AND NOX_EPETRA_INCLUDE_PATH AND NOX_EPETRA_LIBRARY)

IF(EPETRAEXT_INCLUDE_PATH AND EPETRAEXT_LIBRARY)
	SET(TRILINOS_INCLUDE_DIR ${TRILINOS_INCLUDE_DIR} ${EPETRAEXT_INCLUDE_PATH})
	SET(TRILINOS_LIBRARIES ${TRILINOS_LIBRARIES} ${EPETRAEXT_LIBRARY})
	SET(HAVE_EPETRAEXT YES)
	find_package_handle_standard_args(EPETRAEXT DEFAULT_MSG EPETRAEXT_LIBRARY)
ENDIF(EPETRAEXT_INCLUDE_PATH AND EPETRAEXT_LIBRARY)

LIST(LENGTH TRILINOS_INCLUDE_DIR LEN)
IF(LEN GREATER 1)
    LIST(REMOVE_DUPLICATES TRILINOS_INCLUDE_DIR)
ENDIF(LEN GREATER 1)


IF(EPETRA_FOUND AND TEUCHOS_FOUND)
	SET(TRILINOS_FOUND TRUE)
ENDIF(EPETRA_FOUND AND TEUCHOS_FOUND)

IF(ZOLTAN_INCLUDE_PATH AND ZOLTAN_LIBRARY)
    SET(TRILINOS_INCLUDE_DIR ${TRILINOS_INCLUDE_DIR} ${ZOLTAN_INCLUDE_PATH})
    SET(TRILINOS_LIBRARIES ${TRILINOS_LIBRARIES} ${ZOLTAN_LIBRARY})
    SET(HAVE_ZOLTAN YES)
    find_package_handle_standard_args(ZOLTAN DEFAULT_MSG ZOLTAN_LIBRARY)
ENDIF(ZOLTAN_INCLUDE_PATH AND ZOLTAN_LIBRARY)

IF(TRILINOS_FOUND)
	MESSAGE(STATUS "Trilinos packages found.")
ELSE (TRILINOS_FOUND)
	MESSAGE(  WARNING "Could not find Trilinos or one of its packages. Please set the cmake var TRILINOS_ROOT or the environment vars TRILINOS_INCLUDE_DIR and TRILINOS_LIBRARY_DIR, note also that if in your system the library have a prefix, like \"libtrilinos_epetra.so\" instead of \"libepetra.so\" you can specify the prefix by the variable -DTRILINOS_LIBRARY_PREFIX=\"trilinos_\" "    )
ENDIF(TRILINOS_FOUND)
