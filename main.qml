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
                id: copiedModel
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
                Layout.preferredWidth: 180
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
                Layout.preferredWidth: 180
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
                Layout.preferredWidth: 180
                selectByMouse: true
                text: "0"
                validator: DoubleValidator {}
                onEditingFinished: {
                    model.rotate(Number.parseFloat(text), Qt.vector3d(0, 0, 1), Node.ParentSpace);
                    text = "0";
                }
            }

            CheckBox {
                id: eulerRotationEditableCheckBox
                Layout.columnSpan: 2
                font.bold: true
                text: "eulerRotation:"
            }

            Label { text: "x: " }
            TextField {
                Layout.preferredWidth: 180
                readOnly: !eulerRotationEditableCheckBox.checked
                selectByMouse: true
                text: model.eulerRotation.x
                validator: DoubleValidator {}
                onEditingFinished: {
                    if (readOnly)
                        return;
                    model.eulerRotation.x = Number.parseFloat(text);
                }
            }

            Label { text: "y: " }
            TextField {
                Layout.preferredWidth: 180
                readOnly: !eulerRotationEditableCheckBox.checked
                selectByMouse: true
                text: model.eulerRotation.y
                validator: DoubleValidator {}
                onEditingFinished: {
                    if (readOnly)
                        return;
                    model.eulerRotation.y = Number.parseFloat(text);
                }
            }

            Label { text: "z: " }
            TextField {
                Layout.preferredWidth: 180
                readOnly: !eulerRotationEditableCheckBox.checked
                selectByMouse: true
                text: model.eulerRotation.z
                validator: DoubleValidator {}
                onEditingFinished: {
                    if (readOnly)
                        return;
                    model.eulerRotation.z = Number.parseFloat(text);
                }
            }

            CheckBox {
                id: rotationEditableCheckBox
                Layout.columnSpan: 2
                font.bold: true
                text: "quaternion:"
            }

            Label { text: "scalar: " }
            TextField {
                Layout.preferredWidth: 180
                readOnly: !rotationEditableCheckBox.checked
                selectByMouse: true
                text: model.rotation.scalar
                validator: DoubleValidator {}
                onEditingFinished: {
                    if (readOnly)
                        return;
                    model.rotation.scalar = Number.parseFloat(text);
                }
            }

            Label { text: "x: " }
            TextField {
                Layout.preferredWidth: 180
                readOnly: !rotationEditableCheckBox.checked
                selectByMouse: true
                text: model.rotation.x
                validator: DoubleValidator {}
                onEditingFinished: {
                    if (readOnly)
                        return;
                    model.rotation.x = Number.parseFloat(text);
                }
            }

            Label { text: "y: " }
            TextField {
                Layout.preferredWidth: 180
                readOnly: !rotationEditableCheckBox.checked
                selectByMouse: true
                text: model.rotation.y
                validator: DoubleValidator {}
                onEditingFinished: {
                    if (readOnly)
                        return;
                    model.rotation.y = Number.parseFloat(text);
                }
            }

            Label { text: "z: " }
            TextField {
                Layout.preferredWidth: 180
                readOnly: !rotationEditableCheckBox.checked
                selectByMouse: true
                text: model.rotation.z
                validator: DoubleValidator {}
                onEditingFinished: {
                    model.rotation.z = Number.parseFloat(text);
                }
            }

            Label {
                Layout.columnSpan: 2
                font.bold: true
                text: "compare rotations:"
            }

            Label {
                Layout.columnSpan: 2
                text: "dot product:"
            }
            Label {}
            TextField {
                readonly property real value: {
                    let q1 = model.rotation;
                    let q2 = copiedModel.rotation;
                    // dotProduct(q1, q2)
                    return q1.scalar * q2.scalar + q1.x * q2.x + q1.y * q2.y + q1.z * q2.z;
                }
                Layout.preferredWidth: 180
                palette.base: Math.abs(value) < 0.99999 ? "#f88" : "white"
                readOnly: true
                selectByMouse: true
                text: value
            }
        }
    }
}
