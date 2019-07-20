import QtQuick 2.7
import QtQuick.Controls 2.1

Item {
	property int findIndex: 0
	Connections{
		target: Controlor
		onSignal_findMusicResult: {
			//if(PName != "我喜欢的音乐"){
				musicListModel.addMusicList(musicName, vocalistName, album, duration)
			//}
		}
	}
	/*function questMusicList()
	{
		var musicListData = new Object();
		musicListData.do_type = 21;
		console.log(JSON.stringify(musicListData));
		ErPanControl.sendData(JSON.stringify(musicListData));
	}
	function isCollection(accountName, PName)
	{
		for(var i = 0; i < leftModel1.count; i++){
			if(accountName == leftModel1.get(i).ownName && PName == leftModel1.get(i).name){
				isCollect = true
				break;
			}else{
				isCollect = false
			}
		}
	}*/
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
						findMusicView.onlineOrLocal(collectPLM, index)
					}
				}
				Text {
					id: oredrText
					width: 30
					anchors.left: parent.left
					anchors.leftMargin: 30
					anchors.verticalCenter: parent.verticalCenter
					text: ListView.indexAt(ListView.currentItem)
					color: favoriteInfo.ListView.view.currentIndex == index ? "" : "#777778"
					font.pointSize: 10
					font.family: "方正中等线简体"
				}
				/*Rectangle {
					id: favoriteImg
					width: 50
					height: parent.height-2
					anchors.left: oredrText.right
					anchors.verticalCenter: parent.verticalCenter
					color: favoriteInfo.color
					Image {
						id: love
						anchors.left: parent.left
						anchors.leftMargin: 3
						anchors.verticalCenter: parent.verticalCenter
						source: isFM ? "qrc:/image/btnfavorite.png" :"qrc:/image/btnlove2.png"
						MouseArea {
							id: favoriteImgArea
							anchors.fill: parent
							hoverEnabled: true
							cursorShape: Qt.PointingHandCursor
							propagateComposedEvents: true
							onClicked: {
								mouse.accepted = false
								collectPLM.currentIndex = index
								if(isLogin){
								if(isFM){
									createMusicListView.questDeleteMusicOfPL(collectPLM.getCurrentTitle(), collectPLM.getCurrentAuthor(), collectPLM.getCurrentAlbum(), username, "我喜欢的音乐")
									love.source = "qrc:/image/btnlove2.png"
									collectPLM.setIsFM(false)
								}else{
									searchResultView.questMusicToPL(username, "我喜欢的音乐", collectPLM.getCurrentTitle(), collectPLM.getCurrentAuthor())
									love.source = "qrc:/image/btnfavorite.png"
									collectPLM.setIsFM(true)
								}
								}else{
									messagetext = "尚未登录！"
									message.width = 160
									message.visible = true
								}
							}
						}
					}
					Image {
						id: down
						anchors.right: parent.right
						anchors.rightMargin: 3
						anchors.verticalCenter: parent.verticalCenter
						source: isDown ? "qrc:/image/btndownload.png" : "qrc:/image/btndownload1.png"
						opacity: downArea.containsMouse ? 1 : 0.8
						MouseArea {
							id: downArea
							anchors.fill: parent
							hoverEnabled: true
							cursorShape: Qt.PointingHandCursor
							propagateComposedEvents: true
							onClicked: {
								if(isDown){
									messagetext = "歌曲已下载！"
									message.width = 200
									message.visible = true
								}else{
									downlist.questDownloadMusic(title, author);
									collectPLM.currentIndex = index
									collectPLM.setIsDown(true)
									down.source = "qrc:/image/btndownload.png"
								}
							}
						}
					}
				}*/
				Text {
					id: titleText
					width: parent.width * 0.3
					anchors.left: oredrText.right
					anchors.leftMargin: 20
					anchors.verticalCenter: parent.verticalCenter
					text: "title"
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
					text: "singer"
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
					text: "albums"
					color: favoriteInfo.ListView.view.currentIndex == index ? "" : "#777778"
					font.pointSize: 10
					font.family: "方正中等线简体"
				}
				Text {
					id: timeText
					anchors.left: albumsText.right
					anchors.leftMargin: 10
					anchors.verticalCenter: parent.verticalCenter
					text: "time"
					color: favoriteInfo.ListView.view.currentIndex == index ? "" : "#777778"
					font.pointSize: 10
					font.family: "方正中等线简体"
				}
			}
		}
	}
}
