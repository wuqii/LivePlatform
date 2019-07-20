#ifndef SCANFILESONGDATA_H
#define SCANFILESONGDATA_H

#include <QAbstractListModel>
#include <QUrl>
#include <QDebug>
#include <QMap>
#include <QQuickImageProvider>
#include <QDir>
class ScanFileSongData: public QAbstractListModel, public QQuickImageProvider, QDir
{
    Q_OBJECT
public:
    explicit ScanFileSongData(QObject *parent = 0);
    //构造函数获取特定文件中的文件名给私有属性
    ScanFileSongData();
    Q_INVOKABLE void scanSongsData(QList<QUrl> paths);
    QString durationToTime(int position) const;
signals:
    void sendFileSongData(QString author, title, albums, time, size,QImage image ,QList<QUrl> musicurls);
private:
    QList<QString> musicFileNames;
    QList<QUrl> musicUrls;
};

#endif // SCANFILESONGDATA_H
