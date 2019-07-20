#ifndef MUSICLIST_H
#define MUSICLIST_H

#include <QString>
#include <QList>
#include <QAbstractListModel>
#include "song.h"

class MusicListModel : public QAbstractListModel {
	Q_OBJECT
public:
	enum SongRole {
		author = Qt::UserRole + 1,
		title,
		albums,
		time,
		size,
		image,
		cover
	};
    //构造函数
	MusicListModel();
	MusicListModel(QString userName, QString musicListName, QString musicListCover, bool isCo);
	MusicListModel(QString musicListName, QString musicListCover);

    //歌曲数量
	int rowCount(const QModelIndex & parent = QModelIndex()) const override;
	QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;

	QString getUserName() const;
	QString getMusicListName() const;
	QString getMusicListCover() const;
	bool getIsCollect() const;
	Q_INVOKABLE QString getSongUrl(int i) const;
	Q_INVOKABLE void addSong(QString title, QString author, QString albums, QString time);
	Q_INVOKABLE QString nextSong();
	Q_INVOKABLE QString preSong();
	Q_INVOKABLE int currentIndex();
//    Q_INVOKABLE void scanfile();

public slots:
	void addInitSong(QString author, QString title, QString albums, QString time, QString size,QImage image ,QUrl musicurls);

private:
	QHash<int, QByteArray> roleNames() const override;

	int index;
	QString m_name, m_listname, m_cover;
	bool m_isCo;
	QList<Song *> songList;
};

#endif // MUSICLIST_H
