#include <QApplication>

#include <QtQuick/QQuickView>

#include "qmltermwidget_plugin.h"

int main(int argc, char **argv)
{
    QApplication app(argc, argv);

    QmltermwidgetPlugin p;
    p.registerTypes("QMLTermWidget"); //HACK

    QQuickView view;
    
    p.initializeEngine(view.engine(), "QMLTermWidget");
    
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.setSource(QUrl("qrc:/test-app.qml"));
    view.show();

    return app.exec();
}
