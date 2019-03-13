include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../src/libexpat/)

# If pkg-config is not installed on the system, then the
# CHECK_INSTALL_DIR variable must be set to the install
# location of Check. For example, on Windows, this may
# be: C:/Program Files/check
# set(CHECK_INSTALL_DIR "C:/Program Files/check")

find_package(Check REQUIRED)
if(CHECK_FOUND)
    include_directories(${CHECK_INCLUDE_DIRS})
    link_directories(${CHECK_LIBRARY_DIRS})

    set(TEST_SOURCES
    chardata.c
    structdata.c
    minicheck.c
    memcheck.c
    )

    add_executable(runtests runtests.c ${TEST_SOURCES})
    set_property(TARGET runtests PROPERTY RUNTIME_OUTPUT_DIRECTORY tests)
    target_link_libraries(runtests libexpat ${CHECK_LIBRARIES})

    add_executable(runtestspp runtestspp.cpp ${TEST_SOURCES})
    set_property(TARGET runtestspp PROPERTY RUNTIME_OUTPUT_DIRECTORY tests)
    target_link_libraries(runtestspp libexpat ${CHECK_LIBRARIES})
else(CHECK_FOUND)
    message(FATAL_ERROR "Test option is enabled, but \"Check\" was not found")
endif(CHECK_FOUND)
