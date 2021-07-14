import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import QtQuick3D 1.15
import QtQuick3D.Helpers 1.15

Window {
    id: root

    width: 1200
    height: 900
    visible: true

    GridLayout {
        anchors.fill: parent
        flow: GridLayout.TopToBottom
        rows: 2

        View3D {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                anchors.fill: parent
                z: -1
                color: "#222"
            }

            Text {
                color: "white"
                font.bold: true
                text: "main view"
            }

            DirectionalLight {
                ambientColor: "#cccccc"
                brightness: 100
            }

            OrthographicCamera {
                id: camera
                y: 200
                z: 5000
            }

            Node {
                id: model

                Model {
                    source: "#Cone"
                    materials: DefaultMaterial {
                        diffuseColor: "blue"
                    }
                }

                AxisHelper {
                    enableXZGrid: false
                    opacity: 0.5
                    scale: Qt.vector3d(0.2, 0.2, 0.2)
                }
            }

            AxisHelper {
            }

            WasdController {
                controlledObject: camera
            }
        }

        View3D {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                anchors.fill: parent
                z: -1
                color: "#222"
            }

            Text {
                color: "white"
                font.bold: true
                text: "copies eulerRotation from main view"
            }

            DirectionalLight {
                ambientColor: "#cccccc"
                brightness: 100
            }

            OrthographicCamera {
                position: camera.position
                rotation: camera.rotation
                scale: camera.scale
            }

            Node {
                eulerRotation: model.eulerRotation

                Model {
                    source: "#Cone"
                    materials: DefaultMaterial {
                        diffuseColor: "blue"
                    }
                }

                AxisHelper {
                    enableXZGrid: false
                    opacity: 0.5
                    scale: Qt.vector3d(0.2, 0.2, 0.2)
                }
            }

            AxisHelper {
            }

            WasdController {
                controlledObject: camera
            }
        }

        GridLayout {
            Layout.alignment: Qt.AlignTop
            Layout.rowSpan: 2
            columns: 2

            Button {
                Layout.columnSpan: 2
                text: "reset rotation"
                onClicked: {
                    model.rotation = Qt.quaternion(1, 0, 0, 0);
                }
            }

            Button {
                Layout.columnSpan: 2
                text: "emit eulerRotationChanged"
                onClicked: {
                    model.eulerRotationChanged();
                }
            }

            Label {
                Layout.columnSpan: 2
                font.bold: true
                text: "rotate in parent space:"
            }

            Label { text: "x:" }
            TextField {
                selectByMouse: true
                text: "0"
                validator: DoubleValidator {}
                onEditingFinished: {
                    model.rotate(Number.parseFloat(text), Qt.vector3d(1, 0, 0), Node.ParentSpace);
                    text = "0";
                }
            }

            Label { text: "y:" }
            TextField {
                selectByMouse: true
                text: "0"
                validator: DoubleValidator {}
                onEditingFinished: {
                    model.rotate(Number.parseFloat(text), Qt.vector3d(0, 1, 0), Node.ParentSpace);
                    text = "0";
                }
            }

            Label { text: "z:" }
            TextField {
                selectByMouse: true
                text: "0"
                validator: DoubleValidator {}
                onEditingFinished: {
                    model.rotate(Number.parseFloat(text), Qt.vector3d(0, 0, 1), Node.ParentSpace);
                    text = "0";
                }
            }

            Label {
                Layout.columnSpan: 2
                font.bold: true
                text: "eulerRotation:"
            }

            Label { text: "x: " }
            Label { text: model.eulerRotation.x.toFixed(3) }

            Label { text: "y: " }
            Label { text: model.eulerRotation.y.toFixed(3) }

            Label { text: "z: " }
            Label { text: model.eulerRotation.z.toFixed(3) }

            Label {
                Layout.columnSpan: 2
                font.bold: true
                text: "quaternion:"
            }

            Label { text: "scalar: " }
            Label { text: model.rotation.scalar.toFixed(3) }

            Label { text: "x: " }
            Label { text: model.rotation.x.toFixed(3) }

            Label { text: "y: " }
            Label { text: model.rotation.y.toFixed(3) }

            Label { text: "z: " }
            Label { text: model.rotation.z.toFixed(3) }
        }
    }
}
