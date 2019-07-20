#ifndef MUSICLISTMODEL_H
#define MUSICLISTMODEL_H

#include <QAbstractListModel>
#include <QImage>

class MusicList {
public:
	MusicList(QString userName, QString musicListName, QString musicListCover, bool isCo) : m_name(userName), m_listname(musicListName), m_cover(musicListCover), m_isCo(isCo) {}
	MusicList(QString musicListName, QString musicListCover) : m_listname(musicListName), m_cover(musicListCover) {}
	QString getUserName() const{return m_name;}
	QString getMusicListName() const {return m_listname;}
	QString getMusicListCover() const {return m_cover;}
	bool getIsCollect() const {return m_isCo;}

private:
	QString m_name, m_listname, m_cover;
	bool m_isCo;
};

class MusicListModel : public QAbstractListModel
{
	Q_OBJECT
public:
	explicit MusicListModel(QObject *parent = 0);
	int currentIndex() const;
	int rowCount(const QModelIndex & parent = QModelIndex()) const;
	QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
	Q_INVOKABLE void addMusicList(QString uname, QString lname, QString cover, bool isCo);
	Q_INVOKABLE void addList(QString lname, QString cover);
	Q_INVOKABLE QString getCurrentUName() const;
	Q_INVOKABLE QString getCurrentPName() const;
	Q_INVOKABLE QString getCurrentPName(int i) const;
	Q_INVOKABLE QString getCurrentCover() const;
	Q_INVOKABLE bool getCurrentIsCo() const;
	Q_INVOKABLE void setIsCo(const bool &isCo);
	Q_INVOKABLE int count() const;
	Q_INVOKABLE void clear();
	Q_PROPERTY(int currentIndex READ currentIndex WRITE setCurrentIndex NOTIFY currentIndexChanged)
	void setCurrentIndex(const int & i);
	enum musicListRole {
		uNameRole = Qt::UserRole + 1,
		lNameRole,
		coverRole,
		isCoRole
	};

signals:
	void currentIndexChanged();

public slots:

private:
	QHash<int, QByteArray> roleNames() const;

	int m_currentIndex;
	QList<MusicList> musicListData;
};

#endif // MUSICLISTMODEL_H
