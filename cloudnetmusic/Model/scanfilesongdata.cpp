#include "scanfilesongdata.h"
#include <QTime>
extern "C"{
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libswresample/swresample.h>
}

ScanFileSongData::ScanFileSongData(QObject *parent)
{}

void ScanFileSongData::startScan()
{
    QString filePath = "/root/build-cloud-Desktop_Qt_5_11_1_GCC-Debug/music/";
    //qDebug() << filePath;

	QDir *dir=new QDir(filePath);
	QStringList filter;
	QList<QFileInfo> *fileInfo=new QList<QFileInfo>(dir->entryInfoList(filter));
	//文件名称、文件路径：
	for(int i = 0;i<fileInfo->count(); i++)
	{
		auto path = fileInfo->at(i).filePath();
		if(path[path.length() - 1] == '.')
			continue;
		musicUrls.append(QUrl(fileInfo->at(i).filePath()));
		musicFileNames.append(fileInfo->at(i).fileName());
	}
	scanSongsData(musicUrls);
}

void ScanFileSongData::scanSongsData(QList<QUrl> paths)
{
	QString author, title, albums, time, size;
	QImage image;
	int count = paths.count();
	for (int index = 0; index < count; index ++) {
		qDebug() << paths.at(index).path();
		AVFormatContext *pFormatCtx = NULL;
		AVDictionaryEntry *tag = NULL;
		av_register_all();
		QString filepath = paths.at(index).path();
		QByteArray byte = filepath.toLocal8Bit();
		char *file = byte.data();
		if (avformat_open_input(&pFormatCtx, file, NULL, NULL) != 0)//打开文件
			printf("Couldn't open input file\n");
		if (avformat_find_stream_info(pFormatCtx, NULL) < 0)//检测文件流信息
			printf("Not Found Stream Info\n");

		if((tag = av_dict_get(pFormatCtx->metadata, "album", tag, AV_DICT_IGNORE_SUFFIX))){
			albums = tag->value;
		}
		if((tag = av_dict_get(pFormatCtx->metadata, "artist", tag, AV_DICT_IGNORE_SUFFIX))){
			author = tag->value;
		}
		if((tag = av_dict_get(pFormatCtx->metadata, "title", tag, AV_DICT_IGNORE_SUFFIX))){
			title = tag->value;
		}
		int tns;
		tns  = (pFormatCtx->duration)/1000000;
		time = durationToTime(tns*1000);
		double sizeNum = ((pFormatCtx->bit_rate)*tns)/8/1024;
		if((sizeNum/1024) <= 1){
			size.sprintf("%.0fKB", sizeNum);
		}
		else{
			size.sprintf("%.1fMB",sizeNum/1024);
		}
		if (pFormatCtx->iformat->read_header(pFormatCtx) < 0) {
			printf("No header format");
			return;
		}
		for (unsigned int i = 0; i < pFormatCtx->nb_streams; i++){
			if (pFormatCtx->streams[i]->disposition & AV_DISPOSITION_ATTACHED_PIC) {
				AVPacket pkt = pFormatCtx->streams[i]->attached_pic;//使用QImage读取完整图片数据（注意，图片数据是为解析的文件数据，需要用QImage::fromdata来解析读取）
				image = QImage::fromData((uchar*)pkt.data, pkt.size);
				break;
			}
        }
		av_dict_free(&pFormatCtx->metadata);
		avformat_close_input(&pFormatCtx);
		sendFileSongData(author,title,albums,time,size,image,paths.at(index));
		author = title = albums = time = size = "";
    }
}


QString ScanFileSongData::durationToTime(int position) const
{
	position = position / 1000;
	QTime currentTime((position/3600)%60, (position/60)%60, position%60, (position*1000)%1000);
	QString format = "mm:ss";
	if (position > 3600)
		format = "hh:mm:ss";
	return currentTime.toString(format);
}
