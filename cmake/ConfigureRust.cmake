# See: https://github.com/XiangpengHao/cxx-cmake-example

set (CMAKE_CXX_STANDARD 17)

option (ENABLE_LTO "Enable cross language linking time optimization" ON)
if(ENABLE_LTO)
    include(CheckIPOSupported)
    check_ipo_supported(RESULT supported OUTPUT error)
    if(supported)
        if (USE_LD STREQUAL "LLD")
            message(STATUS "IPO / LTO enabled.")
            set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
            #add_link_options(-fuse-ld=lld)
        else()
            message(STATUS "IPO / LTO supported, but not enabled for linker ${USE_LD}  (add -DUSE_LD=LLD to enable)")
        endif()
    else()
        message(STATUS "IPO/LTO not supported.")
        # TODO: Add gold to dev VM.
        #message(STATUS "Error message: ===== ${error} =====")
    endif()
endif()

# Generated by cargo build, so these live in the output directory.
include_directories(${CMAKE_BINARY_DIR}/rust)

add_subdirectory(rust)