#ifndef SONG_H
#define SONG_H

#include <QUrl>
#include <QImage>
#include <QObject>

class Song : public QObject
{
	Q_OBJECT
public:
	explicit Song(QObject *parent = nullptr);
	Song(QString title, QString author, QString albums, QString time, QObject *parent = nullptr);
	Song(QUrl path, QString title, QString author, QString albums, QString time, QString size, QImage image, QObject *parent = nullptr);
	Song(QString title, QString author, QString albums, QString time, QString size, QImage image, QObject *parent = nullptr);
	Song(QString title, QString author, QString albums, QString time, QString size, QString cover, QObject *parent = nullptr);
	Song(QString title, QString author, QString albums, QString time, bool isFM, bool isDown, QObject *parent = nullptr);
	~Song() override = default;
	QString getAuthor() const;
	QString getTitle() const;
	QString getAlbums() const;
	QString getTime() const;
	QString getSize() const;
	QImage getImage() const;
	QString getCover() const;
	QUrl getPath() const;
	bool getIsFM() const;
	bool getIsDown() const;
	void setAuthor(QString author);
	void setTitle(QString title);
	void setAlbums(QString albums);
	void setTime(QString time);
	void setSize(QString size);
	void setImage(QImage image);
	void setIsFM(bool isFM);
	void setIsDown(bool isDown);
	void setCover(QString cover);

private:
	QString m_author, m_title, m_albums, m_time, m_size, m_cover;
	QImage m_image;
	QUrl m_path;
	bool m_isFM, m_isDown;
};

#endif // SONG_H
