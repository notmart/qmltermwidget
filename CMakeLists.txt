CMAKE_MINIMUM_REQUIRED(VERSION 3.1)
ADD_DEFINITIONS("-std=c++11")

PROJECT(term)

SET(QT_MIN_VERSION  "5.7.0")
set(CMAKE_BUILD_TYPE DEBUG)

IF(POLICY CMP0063)
    CMAKE_POLICY(SET CMP0063 NEW)
ENDIF(POLICY CMP0063)

INCLUDE_DIRECTORIES(SYSTEM ${Qt5Core_INCLUDES})
INCLUDE_DIRECTORIES(${CMAKE_SOURCE_DIR}/lib/)
INCLUDE_DIRECTORIES(${CMAKE_SOURCE_DIR}/src/)

find_package(Qt5 ${QT_MIN_VERSION} CONFIG REQUIRED COMPONENTS
    Core
    Quick
    QuickWidgets
    Widgets
    QuickControls2
)

ADD_DEFINITIONS( -D HAVE_POSIX_OPENPT)
ADD_DEFINITIONS( -D HAVE_SYS_TIME_H)
#macx:DEFINES += HAVE_UTMPX _UTMPX_COMPAT


SET(term_SRC
lib/BlockArray.cpp
lib/ColorScheme.cpp
lib/Emulation.cpp
lib/Filter.cpp
lib/History.cpp
lib/HistorySearch.cpp
lib/KeyboardTranslator.cpp
lib/ProcessInfo.cpp
lib/Pty.cpp
lib/Screen.cpp
lib/ScreenWindow.cpp
lib/Session.cpp
lib/ShellCommand.cpp
lib/TerminalCharacterDecoder.cpp
lib/TerminalDisplay.cpp
lib/Vt102Emulation.cpp
lib/konsole_wcwidth.cpp
lib/kprocess.cpp
lib/kpty.cpp
lib/kptydevice.cpp
lib/kptyprocess.cpp
lib/tools.cpp
src/ksession.cpp
src/qmltermwidget_plugin.cpp
src/main.cpp
)

QT5_ADD_RESOURCES(term_SRC
    qml.qrc
)

set(CMAKE_AUTOMOC ON)

ADD_EXECUTABLE( term ${term_SRC} )

TARGET_LINK_LIBRARIES( term
    Qt5::Core
    Qt5::Gui
    Qt5::Widgets
    Qt5::Quick
    Qt5::QuickControls2
    ${CMAKE_THREAD_LIBS_INIT}
)

