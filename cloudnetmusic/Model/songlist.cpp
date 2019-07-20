#include "songlist.h"

SongList::SongList()
{

}

SongList::SongList(QUrl path, QString title, int number, QString imageurl, QObject *parent)
{
    path = m_path;
    m_title = title;
    m_countnumber = number;
    m_imagepath = imageurl;
}

SongList::SongList(QString title, int number, QString imageurl, QObject *parent)
{
    m_title = title;
    m_countnumber = number;
    m_imagepath = imageurl;
}

SongList::SongList(QUrl path, QString title, QImage image, int number, QObject *parent)
{
    m_path = path;
    m_title = title;
    m_image = image;
    m_countnumber = number;
}

QString SongList::title() const
{
    return m_title;
}

void SongList::setTitle(const QString &title)
{
    m_title = title;
}

int SongList::countnumber() const
{
    return m_countnumber;
}

void SongList::setCountnumber(int countnumber)
{
    m_countnumber = countnumber;
}

QImage SongList::image() const
{
    return m_image;
}

void SongList::setImage(const QImage &image)
{
    m_image = image;
}

QUrl SongList::path() const
{
    return m_path;
}

void SongList::setPath(const QUrl &path)
{
    m_path = path;
}

QString SongList::imagepath() const
{
    return m_imagepath;
}

void SongList::setImagepath(const QString &imagepath)
{
    m_imagepath = imagepath;
}


