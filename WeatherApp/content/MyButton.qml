import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    width: 300
    height: 200
    Rectangle {
        id: buttonArea
        color: "blue"
        anchors.fill: parent
        Text {
            anchors.centerIn: buttonArea
            text: "Click me"
        }
        MouseArea {
            anchors.fill: buttonArea
            onPressed: {
                root.scale = 0.9
                buttonArea.color = "red"
            }
            onReleased: {
                root.scale = 1.0
                buttonArea.color = "blue"
            }
        }
    }
}
