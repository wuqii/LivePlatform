#include "song.h"

Song::Song(QObject *parent)
	: QObject (parent)
{}

Song::Song(QString title, QString author, QString albums, QString time, QObject *parent)
	: QObject (parent)
{
	m_author = author;
	m_title = title;
	m_albums = albums;
	m_time = time;
}

Song::Song(QUrl path, QString title, QString author, QString albums, QString time, QString size, QImage image, QObject *parent)
	: QObject (parent)
{
	m_author = author;
	m_path = path;
	m_title = title;
	m_albums = albums;
	m_time = time;
	m_size = size;
	m_image = image;
}

Song::Song(QString title, QString author, QString albums, QString time, QString size, QImage image, QObject *parent)
	: QObject (parent)
{
	m_author = author;
	m_title = title;
	m_albums = albums;
	m_time = time;
	m_size = size;
	m_image = image;
}

Song::Song(QString title, QString author, QString albums, QString time, QString size, QString cover, QObject *parent)
	: QObject (parent)
{
	m_author = author;
	m_title = title;
	m_albums = albums;
	m_time = time;
	m_size = size;
	m_cover = cover;
}

Song::Song(QString title, QString author, QString albums, QString time, bool isFM, bool isDown, QObject *parent)
	: QObject (parent)
{
	m_author = author;
	m_title = title;
	m_albums = albums;
	m_time = time;
	m_isFM = isFM;
	m_isDown = isDown;
}

QString Song::getAuthor() const {
	return m_author;
}

QUrl Song::getPath() const {
	return m_path;
}

bool Song::getIsFM() const
{
	return m_isFM;
}

bool Song::getIsDown() const
{
	return m_isDown;
}

QString Song::getTitle() const {
	return m_title;
}

QString Song::getAlbums() const
{
	return m_albums;
}

QString Song::getTime() const
{
	return m_time;
}

QString Song::getSize() const
{
	return m_size;
}

QImage Song::getImage() const
{
	return m_image;
}

QString Song::getCover() const
{
	return m_cover;
}

void Song::setAuthor(QString author) {
	m_author = author;
}

void Song::setTitle(QString title) {
	m_title = title;
}

void Song::setAlbums(QString albums)
{
	m_albums = albums;
}

void Song::setTime(QString time)
{
	m_time = time;
}

void Song::setSize(QString size)
{
	m_size = size;
}

void Song::setImage(QImage image)
{
	m_image = image;
}

void Song::setIsFM(bool isFM)
{
	m_isFM = isFM;
}

void Song::setIsDown(bool isDown)
{
	m_isDown = isDown;
}
