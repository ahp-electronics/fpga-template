cmake_minimum_required(VERSION 3.0)
PROJECT(fpga_tools C)

LIST(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules/")
LIST(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../cmake_modules/")
set(BIN_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/bin")

find_package(URJTAG REQUIRED)

include_directories( ${CMAKE_CURRENT_BINARY_DIR})
include_directories( ${CMAKE_CURRENT_SOURCE_DIR})
include_directories( ${URJTAG_INCLUDE_DIR})

include(CMakeCommon)

if (URJTAG_FOUND)

set(PROG_SRCS
        ${CMAKE_CURRENT_SOURCE_DIR}/prog.c
)

add_executable(program_jtag ${PROG_SRCS})

target_link_libraries(program_jtag ${URJTAG_LIBRARIES})

install(TARGETS program_jtag RUNTIME DESTINATION bin)

endif (URJTAG_FOUND)
