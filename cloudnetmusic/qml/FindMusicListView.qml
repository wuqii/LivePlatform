import QtQuick 2.7
import QtQuick.Controls 2.1
import DataModel 1.0

Item {
	property int findIndex: 0

	property alias musicListModel : musicListModel
    signal playMusic(string url)

	MusicListModel {
        id: musicListModel
	}

//	Connections {
//		target: Controlor
//		onSignal_findMusicListDetail: {
//			musicListModel.addSong(songTitle, songAuthor, songAlbums, songTime)
//		}
//	}

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
				text: qsTr("歌曲列表")
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
		anchors.top: titleRectangle.bottom
		anchors.bottom: parent.bottom
		width: parent.width
		ListView {
			id: favoriteList
			height: parent.height
			anchors.left: parent.left
			anchors.leftMargin: 30
			anchors.right: parent.right
			anchors.rightMargin: 30
			clip: true
			model: musicListModel
			delegate: Rectangle {
				id: favoriteInfo
				width: parent.width
				height: 30
				color:  ListView.view.currentIndex == index ? "#eeeeee" : (favoriteArea.containsMouse ? "#f7f7f7" : "white");
				MouseArea {
					id: favoriteArea
					anchors.fill: parent
					hoverEnabled: true
					acceptedButtons: Qt.LeftButton | Qt.RightButton
					onClicked: {
						favoriteInfo.ListView.view.currentIndex = index
						if (mouse.button == Qt.RightButton) { // 右键菜单
							contentMenu.x = mouseX
							contentMenu.y = mouseY
							contentMenu.open()
						}
					}
					onDoubleClicked: {
						playMusic(musicListModel.getSongUrl(index))
					}
				}
				Text {
					id: oredrText
					width: 30
					anchors.left: parent.left
					anchors.leftMargin: 30
					anchors.verticalCenter: parent.verticalCenter
					text: index + 1
					color: favoriteInfo.ListView.view.currentIndex == index ? "" : "#777778"
					font.pointSize: 10
					font.family: "方正中等线简体"
				}

				Text {
					id: titleText
					width: parent.width * 0.3
					anchors.left: oredrText.right
					anchors.leftMargin: 20
					anchors.verticalCenter: parent.verticalCenter
					text: title
					color: favoriteInfo.ListView.view.currentIndex == index ? "" : "#777778"
					font.pointSize: 10
					font.family: "方正中等线简体"
				}
				Text {
					id: singerText
					width: parent.width * 0.2
					anchors.left: titleText.right
					anchors.leftMargin: 10
					anchors.verticalCenter: parent.verticalCenter
					text: author
					color: favoriteInfo.ListView.view.currentIndex == index ? "" : "#777778"
					font.pointSize: 10
					font.family: "方正中等线简体"
				}
				Text {
					id: albumsText
					width: parent.width * 0.2
					anchors.left: singerText.right
					anchors.leftMargin: 10
					anchors.verticalCenter: parent.verticalCenter
					text: albums
					color: favoriteInfo.ListView.view.currentIndex == index ? "" : "#777778"
					font.pointSize: 10
					font.family: "方正中等线简体"
				}
				Text {
					id: timeText
					anchors.left: albumsText.right
					anchors.leftMargin: 10
					anchors.verticalCenter: parent.verticalCenter
					text: time
					color: favoriteInfo.ListView.view.currentIndex == index ? "" : "#777778"
					font.pointSize: 10
					font.family: "方正中等线简体"
				}
			}
		}
	}
}
