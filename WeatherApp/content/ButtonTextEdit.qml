// ButtonTextEdit.qml

import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    width: 300
    height: 300

    property string buttonText: "Click me"
    property string textEditText: "Type here"

    signal myButtonClicked();
    signal textSubmitted(string text)

    property alias buttonColor: myButton.palette.button
    property alias textEditColor: textEdit.color

    Row {
        spacing: 10

        Button {
            id: myButton
            palette {
                    button: "green"
                }
            text: buttonText
            onClicked: {
                root.myButtonClicked()
                root.textSubmitted(textEdit.text)
            }
        }

        TextEdit {
            id: textEdit
            color: "red"
            width: 200
            height: 50
            font.pixelSize: 20
            text: textEditText

        }

    }


}
