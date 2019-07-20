#include "musiclistmodel.h"
#include "scanfilesongdata.h"

MusicListModel::MusicListModel()
	: index{0}
{
	ScanFileSongData scan(dynamic_cast<QObject *>(this));
	connect(&scan, &ScanFileSongData::sendFileSongData, this, &MusicListModel::addInitSong);
	qDebug() << "MusicListModel";
	scan.startScan();
}

MusicListModel::MusicListModel(QString userName, QString musicListName, QString musicListCover, bool isCo)
	: index{0}, m_name(userName), m_listname(musicListName), m_cover(musicListCover), m_isCo(isCo)
{
	ScanFileSongData scan(dynamic_cast<QObject *>(this));
	connect(&scan, &ScanFileSongData::sendFileSongData, this, &MusicListModel::addInitSong);
	qDebug() << "MusicListModel";
	scan.startScan();
}

MusicListModel::MusicListModel(QString musicListName, QString musicListCover)
	: index{0}, m_listname(musicListName), m_cover(musicListCover)
{
	ScanFileSongData scan(dynamic_cast<QObject *>(this));
	connect(&scan, &ScanFileSongData::sendFileSongData, this, &MusicListModel::addInitSong);
	qDebug() << "MusicListModel";
	scan.startScan();
}



int MusicListModel::rowCount(const QModelIndex &parent) const
{
	Q_UNUSED(parent);
	return songList.count();
}

QVariant MusicListModel::data(const QModelIndex &index, int role) const
{
	if(index.row() < 0 || index.row() >= songList.count())
		return QVariant();
	const Song * const s = songList.at(index.row());
	switch(role)
	{
		case author:	return s->getAuthor();
		case title:		return s->getTitle();
		case albums:	return s->getAlbums();
		case time:		return s->getTime();
		case size:		return s->getSize();
		case image:		return s->getImage();
		case cover:		return s->getCover();
		default:		return QVariant();
	}
}

QString MusicListModel::getUserName() const
{
	return m_name;
}

QString MusicListModel::getMusicListName() const
{
	return m_listname;
}

QString MusicListModel::getMusicListCover() const
{
	return m_cover;
}

bool MusicListModel::getIsCollect() const
{
	return m_isCo;
}

QString MusicListModel::getSongUrl(int i) const
{
	return songList.at(i)->getPath().path();
}

void MusicListModel::addSong(QString title, QString author, QString albums, QString time)
{
	beginInsertRows(QModelIndex(), songList.count(), songList.count());
	songList.push_back(new Song(title, author, albums, time, this));
	endInsertRows();
}

QString MusicListModel::nextSong()
{
    if(++index < songList.count()){}
	else
		index = 0;
	return songList.at(index)->getPath().path();
}

QString MusicListModel::preSong()
{
    if(--index > 0){}
	else
        index = songList.count()-1;
	return songList.at(index)->getPath().path();
}

int MusicListModel::currentIndex()
{
	return index;
}

QHash<int, QByteArray> MusicListModel::roleNames() const
{
	QHash<int, QByteArray> role;
	role[author] = "author";
	role[title] = "title";
	role[albums] = "albums";
	role[time] = "time";
	role[size] = "size";
	role[image] = "image";
	role[cover] = "cover";
	return role;
}

void MusicListModel::addInitSong(QString author, QString title, QString albums, QString time, QString size,QImage image ,QUrl musicurls)
{
	qDebug() << author << " " << title << musicurls;
	beginInsertRows(QModelIndex(), songList.count(), songList.count());
    songList.push_back(new Song(musicurls, title, author, albums, time, size, image, this));
	endInsertRows();
}

