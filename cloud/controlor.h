#ifndef CONTROLOR_H
#define CONTROLOR_H

#include <QObject>
#include <QUrl>

class Controlor : public QObject
{
	Q_OBJECT
public:
	explicit Controlor(QObject *parent);

signals:
	 void signal_findMusicResult(QString musicName,QString vocalistName,QString album,QString duration);
};

#endif // CONTROLOR_H
