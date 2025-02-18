cmake_minimum_required(VERSION 3.6)
include_directories(
    .
    sed -e s/  *([^ ][^ ]*)/1/g -e s////g)
set(SOURCE_FILES
    /ngx_modules.c
    )
add_executable(nginx ${SOURCE_FILES})
target_link_libraries(nginx )
