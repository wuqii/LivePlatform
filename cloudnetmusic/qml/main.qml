import QtQuick 2.7
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0
import QtMultimedia 5.8
import QtGraphicalEffects 1.0

ApplicationWindow {
	id: mainWindow
	visible: true
	minimumWidth: 1020
	minimumHeight: 660
	x: 170
	y: 50
	flags: Qt.FramelessWindowHint
    title: qsTr("网易云音乐")
    property int status: 1

	// top view
	header: TopView {
		id: top
		width: parent.width
		height: 50
	}
	// middle view
	Rectangle{
		id: middle
		anchors.top: top.bottom
		anchors.bottom: hLine.top
		anchors.left: parent.left
		anchors.right: parent.right
		// left
		LeftView {
			width: 230
			height: parent.height
            id: left
            onShow2:{
                findMusicClassifyListView.visible = true
                findMusicListView.visible = false
            }
            onShow1:{
                findMusicClassifyListView.visible = false
                findMusicListView.visible = true
            }
		}
		// line
		Rectangle{
			id: vLine
			width: 1
			height: parent.height
			anchors.left: left.right
			color: "blue"
		}
		// right
		FindMusicListView {
			id: findMusicListView
			anchors.left: vLine.right
			anchors.right: parent.right
            height: parent.height
            onPlayMusic: {
				bottom.player.source = "file:" + url
				bottom.player.play()
            }
		}
        MusicClassifyListView {
            id:findMusicClassifyListView
            visible: false
            anchors.left: vLine.right
            anchors.right: parent.right
            height: parent.height
        }
	}
	// line
	Rectangle{
		id: hLine
		width: parent.width
		height: 1
		anchors.bottom: bottom.top
		color: "blue"
	}
	// bottom view
	BottomView {
		id: bottom
		width: parent.width
		height: 50
		anchors.bottom: parent.bottom
        onNext: {
			bottom.player.source = "file:" + findMusicListView.musicListModel.nextSong()
		}
        onPre: {
            bottom.player.source = "file:" + findMusicListView.musicListModel.preSong()
        }
	}
}
