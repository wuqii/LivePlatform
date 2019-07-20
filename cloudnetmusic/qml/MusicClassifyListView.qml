import QtQuick 2.7
import QtQuick.Controls 2.1
import DataModel 1.0

Item {
	property int findIndex: 0

    property alias musicClassifyListModel : musicClassifyListModel

	// models
    MusicClassifyListModel {
        id: musicClassifyListModel
    }

    Rectangle {
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.right: parent.right
        anchors.rightMargin: 30
        height: 100
        id: titleRectangle
        //visible: !isConnect
        Rectangle {
            id: friendtop
            width: parent.width
            height: 70
            anchors.left: parent.left
            Text {
                id: topText1
                anchors.left: parent.left
                anchors.leftMargin: 3
                anchors.top: parent.top
                anchors.topMargin: 30
                text: qsTr("全部歌单")
                font.pointSize: 14
                font.family: "华文黑体"
                color: "#383839"
            }
            Rectangle {
                id: line1
                width: parent.width
                height: 1
                anchors.top: topText1.bottom
                anchors.topMargin: 10
                color: "green"
            }
        }
    }

    Rectangle {
        id:setPerInfo
        width: parent.width
        height: parent.height
        visible: isConnect
        GridView {
            id: findGirdview
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.right: parent.right
            boundsBehavior: Flickable.OvershootBounds
            ScrollBar.vertical: ScrollBar {}
            cellWidth: (parent.width-60)/5
            cellHeight: (parent.width-60)/5 + 40
            header: Rectangle {
                width: parent.width -30
                height: 70
                anchors.left: parent.left
                Text {
                    id: topText
                    anchors.left: parent.left
                    anchors.leftMargin: 3
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    text: qsTr("全部歌单")
                    font.pointSize: 14
                    font.family: "华文黑体"
                    color: "#383839"
                }
                Rectangle {
                    id: line
                    width: parent.width
                    height: 1
                    anchors.top: topText.bottom
                    anchors.topMargin: 10
                    color: "#E1E1E2"
                }
            }
            model: musicClassifyListModel
            delegate: Rectangle {
                id: showDelegate
                width: findGirdview.cellWidth
                height: findGirdview.cellHeight
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onClicked: {
                    }
                }
                Rectangle {
                    id: topCover
                    width: parent.width -25
                    height: parent.width - 25
                    anchors.centerIn: parent
                    Image {
                        id: cover
                        anchors.fill: parent
                        source: "file:"+imageurl == "" ? "qrc:/image/createcd.png" : "file:"+imageurl
                        onSourceChanged: {
                            console.error(imageurl);

                        }
                    }
                }
                Rectangle {
                    anchors.left: topCover.left
                    anchors.leftMargin: 5
                    anchors.top: topCover.bottom
                    anchors.topMargin: 5
                    Text {
                        id: text
                        anchors.fill: parent
                        text: title
                    }
                }
            }
        }
    }
}
