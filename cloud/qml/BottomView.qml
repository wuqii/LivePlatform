import QtQuick 2.0
import QtMultimedia 5.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0
Item{
    id:kPlayer
    visible: true
    property int status: 1
    //获取影音名称
    function getVedioName(str)
    {
        var url=fd.fileUrl.toString();
        var strList=new Array();
        strList=url.split("/");
        var name=strList[strList.length-1];
        return name;
    }
    Rectangle{
        id:middle
        height: kPlayer.height-50
        width: kPlayer.width
    }
    Column{
        anchors.top:middle.buttom
        Rectangle{
            id:screen
            width:kPlayer.width
            MediaPlayer{
                id:player
                source: fd.fileUrl
                autoPlay: true
                volume: voice.value
            }
        }
        Rectangle{
            id:control
            color:"#80202020"
            border.color: "gray"
            border.width: 1
            width:kPlayer.width
            height: 50
            Row{
                spacing: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10
                anchors.left: parent.left
                //前一首键
                Button{
                    id:preitem
                    width: 15
                    height:15
                    anchors.verticalCenter: parent.verticalCenter
                }
                //开始键
                Rectangle{
                    id:start1
                    width: 30
                    height: 30
                    color: "red"
                    anchors.verticalCenter: parent.verticalCenter
                      //默认播放
                    Image{
                        id:begin
                        source:"./Images/pause.png"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            console.log("dianjile")
                            if(status===1)
                            {
                                player.pause();
                                //tooltip="开始";
                                console.log("start")
                                status=0;
                                begin.source="./Images/play.png"
                            }
                            else{
                                player.play() ;
                                //tooltip="暂停";
                                console.log("pause")
                                status=1;
                                begin.source="./Images/pause.png"
                            }
                        }
                    }
                }
                //下一首键
                Button{
                    id:nextitem
                    width: 15
                    height:15
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    text:parent.currentTime(player.position)
                    color: "white"
                }
                //调节播放速度
                Slider{
                    id:playPos
                    width: kPlayer.width*0.45
                    height: 10
                    maximumValue: player.duration
                    minimumValue: 0
                    value:player.position
                    anchors.verticalCenter: parent.verticalCenter
                    stepSize:1000
                    style: SliderStyle {
                        groove: Rectangle {
                            width: kPlayer.width*0.5
                            height: 8
                            color: "gray"
                            radius: 2
                            Rectangle {
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                width: player.duration>0?parent.width*player.position/player.duration:0
                                color: "blue"
                            }
                        }
                        handle: Rectangle {
                            anchors.centerIn: parent
                            color: control.pressed ? "white" : "darkgray"
                            border.color: "gray"
                            border.width: 2
                            implicitWidth: 15
                            implicitHeight: 15
                            radius:7.5
                            Rectangle{
                                width: parent.width-8
                                height: width
                                radius: width/2
                                color: "blue"
                                anchors.centerIn: parent
                            }
                        }
                    }
                    //点击鼠标设置播放位置
                    MouseArea {
                        property int pos
                        anchors.fill: parent
                        onClicked: {
                            if (player.seekable)
                                pos = player.duration * mouse.x/parent.width
                            player.seek(pos)
                            playPos.value=pos;
                        }
                    }
                }
                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    text:parent.currentTime(player.duration)
                    color: "white"
                }
                //音量图片
                Image{
                    width: 15
                    height: 15
                    source: "./Images/voice.png"
                    anchors.verticalCenter: parent.verticalCenter
                }
                //调节音量
                Slider{
                    id:voice
                    width: kPlayer.width*0.2
                    height: 10
                    value:player.volume
                    stepSize: 0.1
                    maximumValue: 1
                    minimumValue: 0
                    anchors.verticalCenter: parent.verticalCenter
                    style: SliderStyle {
                        groove: Rectangle {
                            implicitWidth: kPlayer.width*0.2
                            implicitHeight: 8
                            color: "gray"
                            radius: 2
                            Rectangle {
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                width: player.volume>0?parent.width*player.volume:0
                                color: "blue"
                            }
                        }
                        handle: Rectangle {
                            anchors.centerIn: parent
                            color: control.pressed ? "white" : "darkgray"
                            border.color: "gray"
                            border.width: 2
                            implicitWidth: 15
                            implicitHeight: 15
                            radius:7.5
                            Rectangle{
                                width: parent.width-8
                                height: width
                                radius: width/2
                                color: "blue"
                                anchors.centerIn: parent
                            }
                        }
                    }
                }
                //打开文件键
                Rectangle{
                    width: 30
                    height: 30
                    //tooltip: "打开文件"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: fd.open()
                    }
                    Image{source: "./Images/add.png"}
                    FileDialog{
                        id:fd
                        nameFilters: ["Vedio Files(*.avi *.mp4 *.mp3 *rmvb *.rm)"]  //格式过滤
                        selectMultiple: false
                    }
                }
                Button{
                    id:playset
                    width: 15
                    height:15
                    anchors.verticalCenter: parent.verticalCenter
                }
                Button{
                    id:playlist
                    width: 15
                    height:15
                    anchors.verticalCenter: parent.verticalCenter
                }


                //时间格式化
                function currentTime(time)
                {
                    var sec= Math.floor(time/1000);
                    var hours=Math.floor(sec/3600);
                    var minutes=Math.floor((sec-hours*3600)/60);
                    var seconds=sec-hours*3600-minutes*60;
                    var hh,mm,ss;
                    if(hours.toString().length<2)
                        hh="0"+hours.toString();
                    else
                        hh=hours.toString();
                    if(minutes.toString().length<2)
                        mm="0"+minutes.toString();
                    else
                        mm=minutes.toString();
                    if(seconds.toString().length<2)
                        ss="0"+seconds.toString();
                    else
                        ss=seconds.toString();
                    return mm+":"+ss
                }
            }
        }
    }
}
