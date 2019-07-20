import QtQuick 2.7
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0

Rectangle {
	property alias searchtext: searchText
	color: "#4884bd"
	MouseArea {
		anchors.fill: parent
		acceptedButtons: Qt.LeftButton
		property bool isMoved: false
		property point clickPos: "0,0"
		onPressed: {
			isMoved = false;
			clickPos  = Qt.point(mouse.x,mouse.y)
			searchText.focus = false
		}
		onPositionChanged: {
			isMoved = true;
			var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
			mainWindow.setX(mainWindow.x+delta.x)
			mainWindow.setY(mainWindow.y+delta.y)
		}
		cursorShape: ((containsPress && isMoved) ? Qt.SizeAllCursor : Qt.ArrowCursor);
		onDoubleClicked: {
			if(mainWindow.visibility == Window.FullScreen)
				mainWindow.showNormal();
			else{
				mainWindow.visibility = Window.FullScreen;
			}
		}
	}
	// logo
	Image{
		id: logo
		cache: true;
		sourceSize.width: 135;
		sourceSize.height: 25;
		anchors.verticalCenter: parent.verticalCenter
		anchors.left: parent.left;
		anchors.leftMargin: 10;
		source: "qrc:/image/icon.png";
	}
	// pre && next
	Row {
		id: btn
		anchors.left: logo.right
		anchors.leftMargin: 40
		anchors.top: parent.top
		anchors.topMargin: 15
		Rectangle {
			id: preBtn
			width: 25
			height: 20
			radius: 2
			border.width: 1
			border.color: "#E1E1E2"
			color: "#4884bd"
			Image {
				sourceSize.width: 20
				sourceSize.height: 20
				anchors.centerIn: parent
				source: "qrc:/image/btnReturn1.png"
				opacity: preArea.containsMouse ? 1.0 : 0.5
			}
			MouseArea {
				id: preArea
				anchors.fill: parent
				hoverEnabled: true
				cursorShape: Qt.PointingHandCursor
			}
		}
		Rectangle {
			id: nextBtn
			width: 25
			height: 20
			radius: 2
			border.width: 1
			border.color: "#E1E1E2"
			color: "#4884bd"
			Image {
				sourceSize.width: 20
				sourceSize.height: 20
				anchors.centerIn: parent
				source: "qrc:/image/btnReturn1.png"
				rotation: 180
				opacity: nextArea.containsMouse ? 1.0 : 0.5
			}
			MouseArea {
				id: nextArea
				anchors.fill: parent
				hoverEnabled: true
				cursorShape: Qt.PointingHandCursor
			}
		}
	}
	// serach box
	Rectangle {
		id: searchRec
		width: 220
		height: 25
		anchors.left: btn.right
		anchors.leftMargin: 15
		anchors.verticalCenter: parent.verticalCenter
		color: "#3b6e9d"
		radius: 20
		focus: true
		Keys.onReturnPressed:  {
			searchText.focus = false
			searchResultView.visible = true
			downlist.visible = false
			lml.visible = false
			findMusicView.visible = false
			favoriteMusicView.visible = false
			log.visible = false
			userView.visible = false
			friendListView.visible = false
			friendView.visible = false
			userSettingView.visible = false
			createMusicListView.visible = false
			searchulm.clear()
			findPLM.clear()
			if(searchResultView.isSong === true)
			{
				searchResultView.questfindMusic();
			}else{
				searchResultView.questFindUser();
			}
		}
		MouseArea {
			anchors.fill: parent
			cursorShape: Qt.IBeamCursor
		}
		TextField {
			id: searchText
			width: parent.width - 30
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			anchors.leftMargin: 10
			font.pixelSize: 12
			maximumLength: 11
			placeholderText: searchText.focus ? "" : qsTr("搜索音乐，歌名，用户")
			selectByMouse: true
			color: "white"
			font.family: "方正中等线简体"
			background: Rectangle {
				color: "#3b6e9d"
			}
		}
		Image {
			id: searhImg
			anchors.right: parent.right
			anchors.rightMargin: 4
			anchors.verticalCenter: parent.verticalCenter
			source: "qrc:/image/btnSearch1.png"
			opacity: sa.containsMouse ? 1.0 : 0.5
			MouseArea {
				id: sa
				anchors.fill: parent
				hoverEnabled: true
				cursorShape: Qt.PointingHandCursor
				onClicked: {
					searchText.focus = false
					searchResultView.visible = true
					downlist.visible = false
					lml.visible = false
					findMusicView.visible = false
					favoriteMusicView.visible = false
					log.visible = false
					userView.visible = false
					friendListView.visible = false
					friendView.visible = false
					userSettingView.visible = false
					createMusicListView.visible = false
					findPLM.clear()
					searchulm.clear()
					if(searchResultView.isSong === true)
					{
						searchResultView.questfindMusic();
					}else{
						searchResultView.questFindUser();
					}
				}
			}
		}
	}
	//设置
	Image {
		id: settingBtn
		anchors.right: line.left
		anchors.rightMargin: 25
		anchors.verticalCenter: parent.verticalCenter
		source: "qrc:/image/btnSetting1.png"
		opacity: settingArea.containsMouse ? 1.0 : 0.5
		MouseArea {
			id: settingArea
			anchors.fill: parent
			hoverEnabled: true
			cursorShape: Qt.PointingHandCursor
			anchors.verticalCenter: parent.verticalCenter
		}
	}
	Rectangle {
		id: line
		width: 1
		height: 25
		anchors.right: rightpart.left
		anchors.rightMargin: 25
		anchors.verticalCenter: parent.verticalCenter
		color: "#7cacc6"
	}
	Row {
		id: rightpart
		anchors.right: parent.right
		anchors.rightMargin: 10
		spacing: 15
		anchors.verticalCenter: parent.verticalCenter
		//最小化
		Image {
			id: miniBtn
			anchors.verticalCenter: parent.verticalCenter
			source: "qrc:/image/btnMini1.png"
			opacity: miniArea.containsMouse ? 1.0 : 0.5
			MouseArea {
				id: miniArea
				anchors.fill: parent
				hoverEnabled: true
				cursorShape: Qt.PointingHandCursor
				onReleased: {
					if (mainWindow == null)
						return
					mainWindow.visibility = Window.Minimized
				}
			}
		}
		//最大化
		Rectangle {
			width: 20
			height: 20
			color: "#4884bd"
			Rectangle {
				id: mixBtn
				anchors.centerIn: parent
				width: 15
				height: 10
				color: "#4884bd"
				border.width: 1.35
				border.color: maxiArea.containsMouse ? "white" : "#7cacc6"
				radius: 2
			}
			MouseArea {
				id: maxiArea
				anchors.fill: parent
				hoverEnabled: true
				cursorShape: Qt.PointingHandCursor
				onReleased: {
					if (mainWindow == null)
						return
					if (mainWindow.visibility == Window.FullScreen)
						mainWindow.showNormal()
					else
						mainWindow.visibility = Window.FullScreen
				}
			}
		}
		//关闭
		Image {
			id: closeBtn
			source: "qrc:/image/btnClose1.png"
			anchors.verticalCenter: parent.verticalCenter
			opacity: closeArea.containsMouse ? 1.0 : 0.5
			MouseArea {
				id: closeArea
				anchors.fill: parent
				hoverEnabled: true
				cursorShape: Qt.PointingHandCursor
				onClicked: {
					if (mainWindow == null)
						return
					mainWindow.close()
					pause()
				}
			}
		}
	}
}
