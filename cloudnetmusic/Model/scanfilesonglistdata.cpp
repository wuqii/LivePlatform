#include "scanfilesonglistdata.h"



ScanFileSongListData::ScanFileSongListData(QObject *paren)
{}

void ScanFileSongListData::startScan()
{
    QString filePath = "/root/build-cloud-Desktop_Qt_5_11_1_GCC-Debug/MUSICTEST/";
    qDebug() << filePath;
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
        qDebug() << fileInfo->at(i).fileName();
    }
    scanSongsListData(musicUrls);
}

void ScanFileSongListData::scanSongsListData(QList<QUrl> paths)
{
    int countnumber = 0;
    QString title;

    QString filePath;
    QString fileNames;
    for(int index = 0;index<paths.count();index++){
        //对于某个文件夹遍历
        filePath = paths.at(index).path();
        QDir *currentDir = new QDir(filePath); //建立QDir实例
        QStringList filter;
        QList<QFileInfo> *fileInfo=new QList<QFileInfo>(currentDir->entryInfoList(filter));

        QStringList fileNameFilter;   //设计文件名过滤器
        fileNameFilter << "*.jpg" << "*.png";
        currentDir->setNameFilters(fileNameFilter);

        countnumber = fileInfo->count()-1;
        fileNames = currentDir->absoluteFilePath(*currentDir->entryList().begin());
        //获取图片文件路径
        //获取数量、标题

        title = musicFileNames.at(index);
        qDebug() <<countnumber<<title;

        sendFileSongListData(title,countnumber,fileNames,paths.at(index));
        filePath = "";
        title = "";
        countnumber = 0;
        fileNames.clear();
    }
}
