#ifndef MUSICLISTMODEL_H
#define MUSICLISTMODEL_H

#include <QAbstractListModel>
#include <QImage>
#include <QPair>
#include "songlist.h"
#include <QString>

class MusicClassifyListModel : public QAbstractListModel
{
	Q_OBJECT
public:
    enum musicListRole {
        title = Qt::UserRole + 1,
        image,
        countnumber,
        imageurl
    };
    //构造函数
    MusicClassifyListModel();


    //歌单数量
	int rowCount(const QModelIndex & parent = QModelIndex()) const;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;

    QString getTitle() const;
    Q_INVOKABLE QString getSongListUrl(int i) const;
//    Q_INVOKABLE void addSongList(QString title，int countnumber);
    Q_INVOKABLE int currentIndex();
    Q_INVOKABLE void addSongList(QString title,int countnum,QString imageurl);

public slots:
    void addInitSongList(QString title,int countnumber,QString imageurl , QUrl musiclisturls);

private:
	QHash<int, QByteArray> roleNames() const;

    int index;
    QString m_title;
    int m_countnumber;
    QString m_songlisturl;
    QList<SongList *> songListLists;
    //QList<QPair<QString, QImage>> musicListData;
};

#endif // MUSICLISTMODEL_H
