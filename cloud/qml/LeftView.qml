import QtQuick 2.0

Rectangle {
	id: allBtn
	width: parent.width
	anchors.top: parent.top
	//anchors.bottom: playingMusic.visible ?  playingMusic.top : parent.bottom
	ListView {
			id: leftview
			anchors.fill: parent
			clip: true
			boundsBehavior: Flickable.OvershootBounds
			header: Rectangle {
				id: topList
				width: 190
				height: 240
				Text {
					id: rd
					width: parent.width
					height: 34
					anchors.left: parent.left
					anchors.leftMargin: 10
					anchors.top: parent.top
					anchors.topMargin: 5
					text: "推荐"
					color: "gray"
					font.family: "华文黑体"
					verticalAlignment: Text.AlignVCenter
				}
				//发现音乐
				Rectangle {
					id: findMusic
					width: parent.width
					height: 30
					anchors.top: rd.bottom
					//color: findMusicListView.visible ? "#eeeeee" : "#FFFFFF"
					Rectangle {
						id: blue1
						width: 3
						height: parent.height
						anchors.left: parent.left
						color: "#4884bd"
						//visible: findMusicListView.visible
					}
					Image {
						id: fi
						anchors.left: findMusic.left
						anchors.leftMargin: 20
						anchors.top: parent.top
						anchors.topMargin: 3
						source: "qrc:/image/btnmusic2.png"
						//opacity: (findMusicArea.containsMouse || findMusicListView.visible) ? 1 : 0.7
					}
					Text {
						id: fm
						anchors.verticalCenter: parent.verticalCenter
						anchors.left: findMusic.left
						anchors.leftMargin: 50
						text: qsTr("发现音乐")
						font.family: "华文黑体"
						//opacity: (findMusicArea.containsMouse || findMusicListView.visible) ? 1 : 0.7
					}
					MouseArea {
						id: findMusicArea
						anchors.fill: parent
						cursorShape: Qt.PointingHandCursor
						hoverEnabled: true
						onClicked: {
							mlm.clear()
							findMusicListView.questMusicList()
							findMusicListView.visible = true
							findMusicView.visible = false
							lml.visible = false
							downlist.visible = false
							favoriteMusicView.visible = false
							log.visible = false
							userView.visible = false
							friendListView.visible = false
							friendView.visible = false
							userSettingView.visible = false
							createMusicListView.visible = false
							collectMusicListView.visible = false
							searchResultView.visible = false
						}
					}
				}
			}
		}
	}
