#include "musiclistmodel.h"

MusicListModel::MusicListModel(QObject *parent) : QAbstractListModel(parent)
{
	m_currentIndex = -1;
}

int MusicListModel::currentIndex() const
{
	return m_currentIndex;
}

int MusicListModel::rowCount(const QModelIndex &parent) const
{
	Q_UNUSED(parent);
	return musicListData.count();
}

QVariant MusicListModel::data(const QModelIndex &index, int role) const
{
	if (index.row() < 0 || index.row() >= musicListData.count())
		return QVariant();
	const MusicList &s = musicListData.at(index.row());
	switch (role) {
	case uNameRole:
		return s.getUserName();
	case lNameRole:
		return s.getMusicListName();
	case coverRole:
		return s.getMusicListCover();
	case isCoRole:
		return s.getIsCollect();
	default:
		return QVariant();
	}
}

void MusicListModel::addMusicList(QString uname, QString lname, QString cover, bool isCo)
{
	beginInsertRows(QModelIndex(), musicListData.count(), musicListData.count());
	musicListData.append(MusicList(uname, lname, cover, isCo));
	endInsertRows();
	if (m_currentIndex < 0 && musicListData.count()) {
		setCurrentIndex(0);
	}
}

void MusicListModel::addList(QString lname, QString cover)
{
	beginInsertRows(QModelIndex(), musicListData.count(), musicListData.count());
	musicListData.append(MusicList(lname, cover));
	endInsertRows();
	if (m_currentIndex < 0 && musicListData.count()) {
		setCurrentIndex(0);
	}
}
QString MusicListModel::getCurrentUName() const
{
	return musicListData.at(m_currentIndex).getUserName();
}
QString MusicListModel::getCurrentPName() const
{
	return musicListData.at(m_currentIndex).getMusicListName();
}

QString MusicListModel::getCurrentPName(int i) const
{
	return musicListData.at(i).getMusicListName();
}
QString MusicListModel::getCurrentCover() const
{
	return musicListData.at(m_currentIndex).getMusicListCover();
}

bool MusicListModel::getCurrentIsCo() const
{
	return musicListData.at(m_currentIndex).getIsCollect();
}

void MusicListModel::setIsCo(const bool &isCo)
{
	beginResetModel();
	musicListData.replace(m_currentIndex, MusicList(musicListData.at(m_currentIndex).getUserName(), musicListData.at(m_currentIndex).getMusicListName(), musicListData.at(m_currentIndex).getMusicListCover(), isCo));
	endResetModel();
	if (m_currentIndex < 0 && musicListData.count()) {
		setCurrentIndex(0);
	}
}
int MusicListModel::count() const
{
	return musicListData.count();
}

void MusicListModel::clear()
{
	beginResetModel();
	musicListData.clear();
	endResetModel();
}

void MusicListModel::setCurrentIndex(const int &i)
{
	if (i >= musicListData.count() && m_currentIndex != 0) {
		m_currentIndex = 0;
		emit currentIndexChanged();
	} else if ((i >= 0) && (i < musicListData.count()) && (m_currentIndex != i)) {
		m_currentIndex = i;
		emit currentIndexChanged();
	}
}

QHash<int, QByteArray> MusicListModel::roleNames() const
{
	QHash<int, QByteArray> role;
	role[uNameRole] = "uname";
	role[lNameRole] = "lname";
	role[coverRole] = "listCover";
	role[isCoRole] = "isCo";
	return role;
}
