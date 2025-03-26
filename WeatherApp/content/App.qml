// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.5
import QtQuick.Controls
import WeatherApp

Window {
    width: mainScreen.width
    height: mainScreen.height

    visible: true
    title: "WeatherApp"

    Text {
       id:helloText
       text: "Hello World"
    }
    MyComponent {
       x: 300
       y: 300
       width: 400
       height: 200
       onMyComponentClicked: {
           helloText.text = "My custom signal is received."
       }
    }
    MyButton {

    }
    ButtonTextEdit {
            anchors.centerIn: parent
            buttonText: "Submit"
            textEditText: "Type here"
            onMyButtonClicked: {
                textEditText = ""
                buttonText= "Submitted"
            }
            onTextSubmitted: {
                console.log("Text submitted:", text)
            }
            buttonColor: "yellow"
            textEditColor: "blue"
    }


}

