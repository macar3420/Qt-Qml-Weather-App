import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 200
    height: 200

    signal myComponentClicked();
    Rectangle {
        id: myRectangle
        anchors.fill: parent
        color: "lightblue"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                myComponentClicked();
            }
        }
    }
}
