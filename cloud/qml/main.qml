import QtQuick 2.7
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0
import QtMultimedia 5.8
import QtGraphicalEffects 1.0
import DataModel 1.0

ApplicationWindow {
	property bool isChecked: true
	property string titlename : ""
	property string authorname : ""
	property string albumname : ""
	property string timename: ""
	property string postime: "00:00"
	property string messagetext: ""
	property string username: ""
	property int playIndex: -1
	property bool isPlay: false
	property int isPlayOnLine: 0
	property bool isPause: false
	property int currentCount: 0
	property url imageSource: ""
	property string musicListName: ""//创建的歌单名
	property url coversource: ""//歌单封面
	property int middleH: middle.height
	property int nextIndex: -1
    property bool isStext: true
	property bool isLogin: false
	property bool isFMusic: false //是否是我喜欢的音乐
	property bool isDownload: false //是否下载
	property bool isFavorite: false
	property bool isShowCollect: false//是否显示收藏歌单
	property bool isCollect: false//是否收藏
	property bool isConnect: true

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
	}

	MusicListModel {
		id: musicListModel
	}
    ScanSongModel {
        id: scanSongModel
    }




}
