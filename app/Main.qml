import QtQuick 2.0
import Ubuntu.Components 1.1
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
    applicationName: "compass.username"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: false

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(50)
    height: units.gu(50)
    property var kot: 0
    Page {
        title: i18n.tr("compass")

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
            anchors.centerIn:parent
            spacing: units.gu(1)
            anchors {
                margins: units.gu(2)
                fill: parent
                horizontalCenter: Column.Center

            }
            Image {
                anchors.horizontalCenter:parent.horizontalCenter
                source: "graphics/compass1.png"
                Image {
                    id: igla
                    source: "graphics/igla.png"
                }

            }

            Label {
                id: label
                objectName: "label"
                text: myType.helloWorld
            }

            Button {
                objectName: "button21"
                width: parent.width

                text: i18n.tr("Calibrate")

                onClicked: {
                    timer1.stop()
                    myType.calibrate()
                    timer1.start()
                }
            }
           /* Label {
                id: label1
                objectName: "label1"
                text: "Put the phone on the horizontal surface (e.g. on a table) and rotate it for at least 360 degrees in 3s."
            }*/
        }
    }
}

