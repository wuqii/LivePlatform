#ifndef CONTROLOR_H
#define CONTROLOR_H

#include <QObject>
#include <QUrl>

#include "Model/song.h"

class Controlor : public QObject
{
	Q_OBJECT
public:
	explicit Controlor(QObject *parent);

signals:
	 void signal_findMusicListDetail(QString songTitle, QString songAuthor, QString songAlbums, QString songTime);
	 void signal_addMusicList(QString listName);
};

#endif // CONTROLOR_H
