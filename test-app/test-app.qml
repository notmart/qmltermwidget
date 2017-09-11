import QtQuick 2.0
import QtQuick.Layouts 1.1
import QMLTermWidget 1.0
import QtQuick.Controls 1.2

Rectangle {
    width: 640
    height: 480

    Action{
        onTriggered: terminal.copyClipboard();
        shortcut: "Ctrl+Shift+C"
    }

    Action{
        onTriggered: terminal.pasteClipboard();
        shortcut: "Ctrl+Shift+V"
    }

    ColumnLayout {
        anchors.fill: parent
        QMLTermWidget {
            id: terminal
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.family: "Monospace"
            font.pointSize: 12
            colorScheme: "cool-retro-term"

            session: QMLTermSession{
                id: mainsession
                initialWorkingDirectory: "$HOME"
                onMatchFound: {
                    console.log("found at: %1 %2 %3 %4".arg(startColumn).arg(startLine).arg(endColumn).arg(endLine));
                }
                onNoMatchFound: {
                    console.log("not found");
                }
            }
            onActiveFocusChanged: {
                if (focus) {
                    Qt.inputMethod.show();
                }
            }
            onTerminalUsesMouseChanged: console.log(terminalUsesMouse);
            onTerminalSizeChanged: console.log(terminalSize);
            Component.onCompleted: mainsession.startShellProgram();

            QMLTermScrollbar {
                terminal: terminal
                width: 20
                Rectangle {
                    opacity: 0.4
                    anchors.margins: 5
                    radius: width * 0.5
                    anchors.fill: parent
                }
            }

        }
        RowLayout {
            ToolButton {
                text: "Tab"
                onClicked: terminal.simulateKeyPress(Qt.Key_Tab, 0, true, 0, "")
            }
            ToolButton {
                text: "←"
                onClicked: terminal.simulateKeyPress(Qt.Key_Left, 0, true, 0, "")
            }
            ToolButton {
                text: "↑"
                onClicked: terminal.simulateKeyPress(Qt.Key_Up, 0, true, 0, "")
            }
            ToolButton {
                text: "→"
                onClicked: terminal.simulateKeyPress(Qt.Key_Right, 0, true, 0, "")
            }
            ToolButton {
                text: "|"
                onClicked: terminal.simulateKeyPress(Qt.Key_Bar, 0, true, 0, "|")
            }
            ToolButton {
                text: "~"
                onClicked: terminal.simulateKeyPress(Qt.Key_AsciiTilde, 0, true, 0, "~")
            }
        }
        Item {
            Layout.minimumHeight: Qt.inputMethod.keyboardRectangle.height
            Layout.fillWidth: true
        }
    }


    Component.onCompleted: terminal.forceActiveFocus();
}
