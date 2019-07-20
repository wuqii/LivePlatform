#ifndef SCANFILESONGDATA_H
#define SCANFILESONGDATA_H

#include <QAbstractListModel>
#include <QUrl>
#include <QDebug>
#include <QMap>
#include <QQuickImageProvider>
#include <QDir>

class ScanFileSongData : public QObject
{
	Q_OBJECT
public:
	explicit ScanFileSongData(QObject *parent = 0);
	//构造函数获取特定文件中的文件名给私有属性
	Q_INVOKABLE void scanSongsData(QList<QUrl> paths);
	QString durationToTime(int position) const;
	void startScan();

signals:
	void sendFileSongData(QString author, QString title, QString albums, QString time, QString size,QImage image ,QUrl musicurls);

private:
	QList<QString> musicFileNames;
	QList<QUrl> musicUrls;
};

#endif // SCANFILESONGDATA_H
