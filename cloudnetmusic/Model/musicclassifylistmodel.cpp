#include "musicclassifylistmodel.h"
#include "scanfilesonglistdata.h"



MusicClassifyListModel::MusicClassifyListModel()
    :index{0}
{
    ScanFileSongListData scan(dynamic_cast<QObject *>(this));
    connect(&scan, &ScanFileSongListData::sendFileSongListData, this, &MusicClassifyListModel::addInitSongList);
    qDebug() << "MusicListModel";
    scan.startScan();
}


int MusicClassifyListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    qDebug()<<songListLists.count();
    return songListLists.count();
}
//
QVariant MusicClassifyListModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= songListLists.count())
        return QVariant();
    const SongList * const s = songListLists.at(index.row());
    switch (role)
    {
        case title:         return s->title();
        case image:         return s->image();
        case countnumber:   return s->countnumber();
        case imageurl:      return s->imagepath();
        default:            return QVariant();
    }
}


//
QString MusicClassifyListModel::getSongListUrl(int i) const
{
    return songListLists.at(i)->path().path();
}
//
void MusicClassifyListModel::addSongList(QString title, int countnum,QString imageurl)
{
    beginInsertRows(QModelIndex(), songListLists.count(),songListLists.count());
    songListLists.push_back(new SongList(title,countnum,imageurl,this));
    endInsertRows();
}

QString MusicClassifyListModel::getTitle() const
{
    return m_title;
}
//
int MusicClassifyListModel::currentIndex()
{
    return index;
}



//void MusicClassifyListModel::addList(QString lname, QImage cover)
//{
//    beginInsertRows(QModelIndex(), musicListData.count(), musicListData.count());
//    musicListData.append(QPair<QString, QImage>(lname, cover));
//    endInsertRows();
//    if (m_currentIndex < 0 && musicListData.count()) {
//        setCurrentIndex(0);
//    }
//}
//QString MusicClassifyListModel::getCurrentName() const
//{
//    return musicListData.at(m_currentIndex).first;
//}

//QString MusicClassifyListModel::getName(int i) const
//{
//    return musicListData.at(i).first;
//}

//QImage MusicClassifyListModel::getCurrentCover() const
//{
//    return musicListData.at(m_currentIndex).second;
//}

//int MusicClassifyListModel::count() const
//{
//    return musicListData.count();
//}

//void MusicClassifyListModel::clear()
//{
//    beginResetModel();
//    musicListData.clear();
//    endResetModel();
//}

//void MusicClassifyListModel::setCurrentIndex(const int &i)
//{
//    if (i >= musicListData.count() && m_currentIndex != 0) {
//        m_currentIndex = 0;
//        emit currentIndexChanged();
//    } else if ((i >= 0) && (i < musicListData.count()) && (m_currentIndex != i)) {
//        m_currentIndex = i;
//        emit currentIndexChanged();
//    }
//}

void MusicClassifyListModel::addInitSongList(QString title,int countnumber,QString imageurl , QUrl musiclisturls)
{
    qDebug()<< title << " " <<imageurl << " " << musiclisturls;
    beginInsertRows(QModelIndex(), songListLists.count(), songListLists.count());
    songListLists.push_back(new SongList(title, countnumber, imageurl,this));
    endInsertRows();
}

QHash<int, QByteArray> MusicClassifyListModel::roleNames() const
{
    QHash<int, QByteArray> role;
    role[title] = "title";
    role[image] = "image";
    role[countnumber] = "countnumber";
    role[imageurl] = "imageurl";
    return role;
}
