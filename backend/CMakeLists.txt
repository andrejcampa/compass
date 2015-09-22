include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set(
    Compassbackend_SRCS
    modules/Compass/backend.cpp
    modules/Compass/mytype.cpp
)

# Make the unit test files visible on qtcreator
add_custom_target(Compassbackend_UNITTEST_QML_FILES ALL SOURCES "tests/unit/tst_mytype.qml")

add_library(Compassbackend MODULE
    ${Compassbackend_SRCS}
)

set_target_properties(Compassbackend PROPERTIES
         LIBRARY_OUTPUT_DIRECTORY Compass)

qt5_use_modules(Compassbackend Gui Qml Quick)

# Copy qmldir file to build dir for running in QtCreator
add_custom_target(Compassbackend-qmldir ALL
    COMMAND cp ${CMAKE_CURRENT_SOURCE_DIR}/modules/Compass/qmldir ${CMAKE_CURRENT_BINARY_DIR}/Compass
    DEPENDS ${QMLFILES}
)

# Install plugin file
install(TARGETS Compassbackend DESTINATION ${QT_IMPORTS_DIR}/Compass/)
install(FILES   modules/Compass/qmldir DESTINATION ${QT_IMPORTS_DIR}/Compass/)

