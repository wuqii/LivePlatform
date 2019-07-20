#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Model/musicclassifylistmodel.h"
#include "Model/musiclistmodel.h"
#include "Model/song.h"
#include "controlor.h"
#include "Model/songlist.h"

int main(int argc, char *argv[])
{
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

	QGuiApplication app(argc, argv);

	Controlor controlor(&app);
	qmlRegisterType<MusicClassifyListModel>("DataModel", 1, 0, "MusicClassifyListModel");
	qmlRegisterType<MusicListModel>("DataModel", 1, 0, "MusicListModel");
	qmlRegisterType<Song>("DataModel", 1, 0, "Song");
    qmlRegisterType<SongList>("DataModel", 1, 0, "SongList");

	QQmlApplicationEngine engine;
	const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
					 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	engine.rootContext()->setContextProperty("Controlor", &controlor);
	engine.load(url);

	/*for (int i = 0; i < 100; ++i) {
		QString title = "title" + QString::number(i);
		QString author = "author" + QString::number(i);
		QString albums = "albums" + QString::number(i);
		QString time = "time" + QString::number(i);
		emit controlor.signal_findMusicListDetail(title, author, albums, time);
	}
	for (int i = 0; i < 100; ++i) {
		QString musicListName  = "musicListName" + QString::number(i);
		emit controlor.signal_addMusicList(musicListName);
	}*/

	return app.exec();
}
