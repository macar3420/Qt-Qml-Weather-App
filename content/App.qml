import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: myWindow
    width: 1000
    height: 900
    visible: true
    title: qsTr("Qt Qml Weather App")

    property real lat
    property real lon

    Rectangle {
        id: weatherUiBackground
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { id: firstGradient; position: 0; color: "blue" }
            GradientStop { id: secondGradient; position: 0.7; color: "darkblue" }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: 48
            anchors.rightMargin: 48
            anchors.topMargin: 36
            anchors.bottomMargin: 36
            spacing: 32

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 12

                TextField {
                    id: cityInput
                    Layout.preferredWidth: 300
                    placeholderText: qsTr("Enter a city")
                    font.pixelSize: 20
                    color: "#1a3d1a"
                    placeholderTextColor: "#6b8f6b"
                    horizontalAlignment: TextInput.AlignHCenter
                    selectionColor: "#a8d4a8"
                    selectedTextColor: "#1a3d1a"
                    onEditingFinished: fetchWeather()

                    background: Rectangle {
                        radius: 10
                        color: "#F5FFFFFF"
                        border.color: "#FFFFFF"
                        border.width: 2
                    }
                }

                Button {
                    Layout.preferredWidth: 88
                    text: qsTr("Enter")
                    font.pixelSize: 18
                    flat: true
                    onClicked: {
                        fetchWeather()
                        fetchData()
                    }

                    contentItem: Text {
                        text: parent.text
                        font.pixelSize: parent.font.pixelSize
                        font.bold: true
                        color: "#666666"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                        radius: 10
                        color: parent.down ? "#E0FFFFFF" : "#F5FFFFFF"
                        border.color: "#FFFFFF"
                        border.width: 2
                    }
                }
            }

            ColumnLayout {
                id: currentWeatherBlock
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 420
                spacing: 10

                Item {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 150
                    Layout.preferredHeight: 150

                    Image {
                        id: img
                        anchors.centerIn: parent
                        width: 130
                        height: 130
                        source: "images/snow.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Text {
                    id: locationText
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                    color: "white"
                    text: qsTr("Location")
                    font.pixelSize: 42
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    id: locationDesc
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                    color: "white"
                    text: qsTr("Sunny")
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    id: temperatureText
                    Layout.fillWidth: true
                    Layout.topMargin: 4
                    Layout.alignment: Qt.AlignHCenter
                    color: "white"
                    text: qsTr("30 °C")
                    font.pixelSize: 34
                    horizontalAlignment: Text.AlignHCenter
                }

                RowLayout {
                    id: rowL
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    Layout.preferredWidth: 560
                    spacing: 20

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 100
                        radius: 14
                        color: "#30ffffff"

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 18
                            spacing: 14

                            Image {
                                source: "images/wind.png"
                                Layout.preferredWidth: 52
                                Layout.preferredHeight: 52
                                fillMode: Image.PreserveAspectFit
                            }
                            ColumnLayout {
                                spacing: 4
                                Text {
                                    color: "white"
                                    text: qsTr("Wind")
                                    font.pixelSize: 18
                                    opacity: 0.9
                                }
                                Text {
                                    id: windSpeed
                                    color: "white"
                                    text: ""
                                    font.pixelSize: 28
                                    font.bold: true
                                }
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 100
                        radius: 14
                        color: "#30ffffff"

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 18
                            spacing: 14

                            Image {
                                source: "images/humidity.png"
                                Layout.preferredWidth: 52
                                Layout.preferredHeight: 52
                                fillMode: Image.PreserveAspectFit
                            }
                            ColumnLayout {
                                spacing: 4
                                Text {
                                    color: "white"
                                    text: qsTr("Humidity")
                                    font.pixelSize: 18
                                    opacity: 0.9
                                }
                                Text {
                                    id: humidityPerc
                                    color: "white"
                                    text: ""
                                    font.pixelSize: 28
                                    font.bold: true
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 900
                Layout.preferredHeight: 1
                Layout.topMargin: 8
                color: "#35ffffff"
            }

            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 900
                Layout.preferredHeight: 240
                spacing: 20

                Text {
                    id: forecastLocation
                    Layout.alignment: Qt.AlignHCenter
                    text: qsTr("Forecast")
                    color: "white"
                    font.pixelSize: 34
                    font.bold: true
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                    Layout.preferredHeight: 190
                    spacing: 14

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 190
                        radius: 16
                        color: "#35ffffff"

                        Column {
                            anchors.centerIn: parent
                            width: parent.width - 12
                            spacing: 10

                            Text {
                                id: day
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                                text: qsTr("Day")
                                color: "white"
                                font.pixelSize: 18
                                font.bold: true
                            }
                            Image {
                                id: img0
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: 72
                                height: 72
                                source: "images/snow.png"
                                fillMode: Image.PreserveAspectFit
                            }
                            Text {
                                id: data
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                                text: qsTr("-- °C")
                                color: "white"
                                font.pixelSize: 24
                                font.bold: true
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 190
                        radius: 16
                        color: "#35ffffff"

                        Column {
                            anchors.centerIn: parent
                            width: parent.width - 12
                            spacing: 10

                            Text {
                                id: day1
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                                text: qsTr("Day")
                                color: "white"
                                font.pixelSize: 18
                                font.bold: true
                            }
                            Image {
                                id: img1
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: 72
                                height: 72
                                source: "images/mist.png"
                                fillMode: Image.PreserveAspectFit
                            }
                            Text {
                                id: data1
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                                text: qsTr("-- °C")
                                color: "white"
                                font.pixelSize: 24
                                font.bold: true
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 190
                        radius: 16
                        color: "#35ffffff"

                        Column {
                            anchors.centerIn: parent
                            width: parent.width - 12
                            spacing: 10

                            Text {
                                id: day2
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                                text: qsTr("Day")
                                color: "white"
                                font.pixelSize: 18
                                font.bold: true
                            }
                            Image {
                                id: img2
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: 72
                                height: 72
                                source: "images/clear.png"
                                fillMode: Image.PreserveAspectFit
                            }
                            Text {
                                id: data2
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                                text: qsTr("-- °C")
                                color: "white"
                                font.pixelSize: 24
                                font.bold: true
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 190
                        radius: 16
                        color: "#35ffffff"

                        Column {
                            anchors.centerIn: parent
                            width: parent.width - 12
                            spacing: 10

                            Text {
                                id: day3
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                                text: qsTr("Day")
                                color: "white"
                                font.pixelSize: 18
                                font.bold: true
                            }
                            Image {
                                id: img3
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: 72
                                height: 72
                                source: "images/drizzle.png"
                                fillMode: Image.PreserveAspectFit
                            }
                            Text {
                                id: data3
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                                text: qsTr("-- °C")
                                color: "white"
                                font.pixelSize: 24
                                font.bold: true
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 190
                        radius: 16
                        color: "#35ffffff"

                        Column {
                            anchors.centerIn: parent
                            width: parent.width - 12
                            spacing: 10

                            Text {
                                id: day4
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                                text: qsTr("Day")
                                color: "white"
                                font.pixelSize: 18
                                font.bold: true
                            }
                            Image {
                                id: img4
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: 72
                                height: 72
                                source: "images/rain.png"
                                fillMode: Image.PreserveAspectFit
                            }
                            Text {
                                id: data4
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                                text: qsTr("-- °C")
                                color: "white"
                                font.pixelSize: 24
                                font.bold: true
                            }
                        }
                    }
                }
            }
        }
    }

    function processJson(response) {
        var weatherJsonOnject = JSON.parse(response)
        try {
            locationText.text = weatherJsonOnject.name
            lat = weatherJsonOnject.coord.lat
            lon = weatherJsonOnject.coord.lon

            locationDesc.text = weatherJsonOnject.weather[0].description
            temperatureText.text = Math.round(weatherJsonOnject.main.temp) + " °C"
            humidityPerc.text = weatherJsonOnject.main.humidity + " %"
            windSpeed.text = weatherJsonOnject.wind.speed + " km/h"
            if (weatherJsonOnject.weather[0].main === "Clouds") {
                img.source = "images/clouds.png"
                firstGradient.color = "black"
                secondGradient.color = "green"
            } else if (weatherJsonOnject.weather[0].main === "Clear") {
                img.source = "images/clear.png"
                firstGradient.color = "lightgreen"
                secondGradient.color = "darkgreen"
            } else if (weatherJsonOnject.weather[0].main === "Rain") {
                img.source = "images/rain.png"
                firstGradient.color = "#4a4a4a"
                secondGradient.color = "#2d2d2d"
            } else if (weatherJsonOnject.weather[0].main === "Drizzle") {
                img.source = "images/drizzle.png"
                firstGradient.color = "red"
                secondGradient.color = "purple"
            } else if (weatherJsonOnject.weather[0].main === "Mist") {
                img.source = "images/mist.png"
                firstGradient.color = "black"
                secondGradient.color = "purple"
            } else if (weatherJsonOnject.weather[0].main === "Snow") {
                img.source = "images/snow.png"
                firstGradient.color = "brown"
                secondGradient.color = "darkred"
            } else if (weatherJsonOnject.weather[0].main === "Fog") {
                img.source = "images/fog.png"
                firstGradient.color = "lightblue"
                secondGradient.color = "black"
            }
        } catch (error) {
            locationText.text = "Error parsing JSON"
        }
    }

    function fetchWeather() {
        var http = new XMLHttpRequest()
        var url = `https://api.openweathermap.org/data/2.5/weather?units=metric&q=${cityInput.text}&appid=126ef9f8c685cc9275b8a0a57fe7b8bd`
        locationText.text = "Fecthing data"
        http.onreadystatechange = function() {
            if (http.readyState === XMLHttpRequest.DONE) {
                if (http.status === 200) {
                    var response = http.responseText
                    processJson(response)
                    fetchData()
                } else {
                    locationText.text = "Error"
                }
            }
        }
        http.open("GET", url)
        http.send()
    }

    function processData(response) {
        var forecastJsonOnject = JSON.parse(response)
        try {
            data.text = Math.round(forecastJsonOnject.list[1].main.temp) + " °C"
            data1.text = Math.round(forecastJsonOnject.list[1 + 8].main.temp) + " °C"
            data2.text = Math.round(forecastJsonOnject.list[1 + 8 + 8].main.temp) + " °C"
            data3.text = Math.round(forecastJsonOnject.list[1 + 8 + 8 + 8].main.temp) + " °C"
            data4.text = Math.round(forecastJsonOnject.list[1 + 8 + 8 + 8 + 8].main.temp) + " °C"

            day.text = getDayOfWeek(forecastJsonOnject.list[1].dt)
            day1.text = getDayOfWeek(forecastJsonOnject.list[1 + 8].dt)
            day2.text = getDayOfWeek(forecastJsonOnject.list[1 + 8 + 8].dt)
            day3.text = getDayOfWeek(forecastJsonOnject.list[1 + 8 + 8 + 8].dt)
            day4.text = getDayOfWeek(forecastJsonOnject.list[1 + 8 + 8 + 8 + 8].dt)

            if (forecastJsonOnject.list[1].weather[0].main === "Clouds") {
                img0.source = "images/clouds.png"
            } else if (forecastJsonOnject.list[1].weather[0].main === "Clear") {
                img0.source = "images/clear.png"
            } else if (forecastJsonOnject.list[1].weather[0].main === "Rain") {
                img0.source = "images/rain.png"
            } else if (forecastJsonOnject.list[1].weather[0].main === "Drizzle") {
                img0.source = "images/drizzle.png"
            } else if (forecastJsonOnject.list[1].weather[0].main === "Mist") {
                img0.source = "images/mist.png"
            } else if (forecastJsonOnject.list[1].weather[0].main === "Snow") {
                img0.source = "images/snow.png"
            } else if (forecastJsonOnject.list[1].weather[0].main === "Fog") {
                img0.source = "images/fog.png"
            }

            if (forecastJsonOnject.list[1 + 8].weather[0].main === "Clouds") {
                img1.source = "images/clouds.png"
            } else if (forecastJsonOnject.list[1 + 8].weather[0].main === "Clear") {
                img1.source = "images/clear.png"
            } else if (forecastJsonOnject.list[1 + 8].weather[0].main === "Rain") {
                img1.source = "images/rain.png"
            } else if (forecastJsonOnject.list[1 + 8].weather[0].main === "Drizzle") {
                img1.source = "images/drizzle.png"
            } else if (forecastJsonOnject.list[1 + 8].weather[0].main === "Mist") {
                img1.source = "images/mist.png"
            } else if (forecastJsonOnject.list[1 + 8].weather[0].main === "Snow") {
                img1.source = "images/snow.png"
            } else if (forecastJsonOnject.list[1 + 8].weather[0].main === "Fog") {
                img1.source = "images/fog.png"
            }

            if (forecastJsonOnject.list[1 + 8 + 8].weather[0].main === "Clouds") {
                img2.source = "images/clouds.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8].weather[0].main === "Clear") {
                img2.source = "images/clear.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8].weather[0].main === "Rain") {
                img2.source = "images/rain.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8].weather[0].main === "Drizzle") {
                img2.source = "images/drizzle.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8].weather[0].main === "Mist") {
                img2.source = "images/mist.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8].weather[0].main === "Snow") {
                img2.source = "images/snow.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8].weather[0].main === "Fog") {
                img2.source = "images/fog.png"
            }

            if (forecastJsonOnject.list[1 + 8 + 8 + 8].weather[0].main === "Clouds") {
                img3.source = "images/clouds.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8 + 8].weather[0].main === "Clear") {
                img3.source = "images/clear.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8 + 8].weather[0].main === "Rain") {
                img3.source = "images/rain.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8 + 8].weather[0].main === "Drizzle") {
                img3.source = "images/drizzle.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8 + 8].weather[0].main === "Mist") {
                img3.source = "images/mist.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8 + 8].weather[0].main === "Snow") {
                img3.source = "images/snow.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8].weather[0].main === "Fog") {
                img3.source = "images/fog.png"
            }

            if (forecastJsonOnject.list[1 + 8 + 8 + 8 + 8].weather[0].main === "Clouds") {
                img4.source = "images/clouds.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8 + 8 + 8].weather[0].main === "Clear") {
                img4.source = "images/clear.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8 + 8 + 8].weather[0].main === "Rain") {
                img4.source = "images/rain.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8 + 8 + 8].weather[0].main === "Drizzle") {
                img4.source = "images/drizzle.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8 + 8 + 8].weather[0].main === "Mist") {
                img4.source = "images/mist.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8 + 8 + 8].weather[0].main === "Snow") {
                img4.source = "images/snow.png"
            } else if (forecastJsonOnject.list[1 + 8 + 8 + 8].weather[0].main === "Fog") {
                img4.source = "images/fog.png"
            }
        } catch (error) {
            data.text = "Error parsing JSON"
        }
    }

    function fetchData() {
        var http = new XMLHttpRequest()
        var url = `https://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${lon}&units=metric&appid=126ef9f8c685cc9275b8a0a57fe7b8bd`

        http.onreadystatechange = function() {
            if (http.readyState === XMLHttpRequest.DONE) {
                if (http.status === 200) {
                    processData(http.responseText)
                } else {
                    data.text = "Error"
                }
            }
        }
        http.open("GET", url)
        http.send()
    }

    function getDayOfWeek(dateString) {
        var date = new Date(dateString * 1000)
        var daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        return daysOfWeek[date.getDay()]
    }
}
