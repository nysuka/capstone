#DEPENDENCY_PROJECT +=

! include( ../Capstone.pri ) {
    error( "$${TARGET} Couldn't find the Capstone.pri file!" )
}

TARGET = Rivus
TEMPLATE = app

QT += core gui widgets
requires(qtConfig(filedialog))

HEADERS += mainwindow.h \
        colorswatch.h \
        toolbar.h

SOURCES += main.cpp \
        mainwindow.cpp \
        colorswatch.cpp \
        toolbar.cpp
