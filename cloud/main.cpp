#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Model/musiclistmodel.h"
#include "controlor.h"
#include "Model/scansongmodel.h"

int main(int argc, char *argv[])
{
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

	QGuiApplication app(argc, argv);

	Controlor controlor(&app);
	qmlRegisterType<MusicListModel>("DataModel", 1, 0, "MusicListModel");
    qmlRegisterType<ScanSongModel>("DataModel", 1, 0, "ScanSongModel");

	QQmlApplicationEngine engine;
	const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
					 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	engine.rootContext()->setContextProperty("Controlor", &controlor);
	engine.load(url);

	for (int i = 0; i < 100; ++i) {
		QString musicName  = "string_musicName" + QString::number(i);
		QString vocalistName = "string_vocalistName" + QString::number(i);
		QString album = "string_album" + QString::number(i);
		QString duration = "string_duration" + QString::number(i);
		emit controlor.signal_findMusicResult(musicName,vocalistName,album,duration);
	}

	return app.exec();
}
