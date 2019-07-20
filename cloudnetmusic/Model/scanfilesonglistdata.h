#ifndef SCANFILESONGLISTDATA_H
#define SCANFILESONGLISTDATA_H

#include <QAbstractListModel>
#include <QUrl>
#include <QDebug>
#include <QMap>
#include <QQuickImageProvider>
#include <QDir>
class ScanFileSongListData : public QObject
{
    Q_OBJECT
public:
    explicit ScanFileSongListData(QObject *parent = 0);
    void startScan();
    Q_INVOKABLE void scanSongsListData(QList<QUrl> paths);
signals:
    void sendFileSongListData(QString title,int number,QString imageurl,QUrl musiclisturls);
private:
    QList<QString> musicFileNames;
    QList<QUrl> musicUrls;
};

#endif // SCANFILESONGLISTDATA_H
