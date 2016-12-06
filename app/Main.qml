import QtQuick 2.4
import Ubuntu.Components 1.3
import Compass 1.0

/*!
    \brief MainView with Tabs element.
           First Tab has a single Label and
           second Tab has a single ToolbarAction.
*/


MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"
    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "compass.kwek" //COMPASS ID
    width: units.gu(100)
    height: units.gu(75)
    property int kot: 0
    Page {
        header: PageHeader {
            id: pageHeader
            title: i18n.tr("Compass")
        }
        Timer {
            id: timer1
            interval: 200; running: true; repeat: true
            onTriggered: {
               kot =  myType.launch()
               myType.helloWorld = kot
               igla.rotation = kot
            }
        }
        MyType {
            id: myType

        }
        Column {
            anchors {
                centerIn:parent
                top: pageHeader.bottom
                topMargin: units.gu(6)
                fill: parent
                horizontalCenter: pageHeader.horizontalCenter
            }
            spacing: units.gu(1)
                Image {
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                    }
                    source: "graphics/compass1.png"
                    Image {
                        id: igla
                        source: "graphics/igla.png"
                    }
                }
            Label {
                id: label
                objectName: "label"
                anchors {
                    topMargin: units.gu(2)
                }
                text: i18n.tr("Azimuth: ")+myType.helloWorld+i18n.tr("°")
            }
            Button {

                objectName: "button21"
                anchors {
                    topMargin: units.gu(2)
                }
                width: parent.width

                text: i18n.tr("Calibrate")

                onClicked: {
                    timer1.stop()
                    myType.calibrate()
                    timer1.start()
                }
            }
        }
    }
}

