#ifndef SONGLIST_H
#define SONGLIST_H

#include <QUrl>
#include <QImage>
#include <QObject>
class SongList : public QObject
{
public:
    SongList();
    SongList(QUrl path,QString title,int number,QString imageurl, QObject *parent = nullptr);
    SongList(QString title,int number,QString imageurl, QObject *parent = nullptr);
    SongList(QUrl path, QString title, QImage image, int number, QObject *parent = nullptr);
    QString title() const;
    void setTitle(const QString &title);

    int countnumber() const;
    void setCountnumber(int countnumber);

    QImage image() const;
    void setImage(const QImage &image);

    QUrl path() const;
    void setPath(const QUrl &path);


    QString imagepath() const;
    void setImagepath(const QString &imagepath);

private:
    QString m_title;
    int m_countnumber;
    QImage m_image;
    QString m_imagepath;
    QUrl m_path;
    //bool m_isFM, m_isDown;

};

#endif // SONGLIST_H
