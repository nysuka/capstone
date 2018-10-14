CONFIG += c++11

QT       += core gui opengl sql
INCLUDEPATH +=  $${PWD}/ExternalLibs/eigen-3.2.0
INCLUDEPATH += $${PWD}/ExternalLibs/boost-1.55.0

#DEFINES += OSG_LIBRARY_STATIC PNG_STATIC_LIBRARY NOMINMAX STATIC_CALLHACK HAVE_CONFIG_H

INCLUDEPATH += $${PWD}
RESOURCES += $$PWD/Docks/Docks.qrc
RC_FILE =  $${PWD}/RC/Icon.rc

TARGET_DIRECTORY_NAME = 0           #The target directory name (just the project folder name)
TARGET_PATH = 0                     #The path to the project directory from the root folder
LIB_PATH = 0                        #The path to the LIB

# [The MACRO]
# The "dep" variable that is used in these two for loops will hold the paramaters from the DEPENDENCY_PROJECT.
# From the example above this would hold projectX and projectY (a litteral string)
# Now this function will loop through all the parameters

# [Setup the Dependencies]
for(dep, DEPENDENCY_PROJECT) {
    TARGET_NAME = $${dep} # The name of the depending target
    #message($${TARGET}.depends = $${TARGET_NAME})
    $${TARGET}.depends += $${TARGET_NAME}
}
# [setup the actual library dependencies]
for(dep, DEPENDENCY_PROJECT) {
    TARGET_NAME = $${dep}                       # The name of the depending target
    TARGET_PATH = $${PWD}/$${TARGET_NAME}        # The path to the depending target source
    LIB_PATH = $${OUT_PWD}/../$${TARGET_NAME}    # The path to the depending compiled target
    #message(Depending target \"$${TARGET_NAME}\" source path: $${TARGET_PATH})
    #message(Depending target \"$${TARGET_NAME}\" compiled path: $${LIB_PATH})

    # Adds the wanted lib to the linker
    win32 {
        win32:CONFIG(release, debug|release): LIBS += -L$${LIB_PATH}/release/ -l$${TARGET_NAME}
        else:win32:CONFIG(debug, debug|release): LIBS += -L$${LIB_PATH}/debug/ -l$${TARGET_NAME}
    }
    unix:!macx {
        LIBS += -L$${LIB_PATH}/ -l$${TARGET_NAME}
        #message(Depending lib to linker "$$LIBS")
    }
    #message(Depending lib to linker "$$LIBS")

    # Adds the wanted lib to the project.
    INCLUDEPATH += $${TARGET_PATH}
    #message(INCLUDEPATH: $${INCLUDEPATH})

    # Adds a dependpath to the project
    # This forces a rebuild if the headers change
    DEPENDPATH += $${TARGET_PATH}
    #message(DEPENDPATH: $${DEPENDPATH})

    #Pre target
    PRE_TARGETDEPS += $${TARGET_PATH}
    #message(PRE_TARGETDEPS: $${PRE_TARGETDEPS})
}


#message("$$LIBS")
