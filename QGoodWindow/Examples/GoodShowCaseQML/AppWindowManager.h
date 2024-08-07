//
// Created by sergei on 7/30/24.
//

#ifndef APPWINDOWMANAGER_H
#define APPWINDOWMANAGER_H

#include <QObject>

#include "mainwindow.h"

class AppWindowManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool isFullScreenMode READ isFullScreenMode WRITE setIsFullScreenMode NOTIFY isFullScreenModeChanged)
    Q_PROPERTY(int titleBarHeight READ titleBarHeight CONSTANT)
    Q_PROPERTY(int smallIconSize READ smallIconSize CONSTANT)
    QML_ELEMENT

public:
    explicit AppWindowManager();

    [[nodiscard]] bool isFullScreenMode() const
    {
        return m_isFullScreenMode;
    }
    void setIsFullScreenMode(bool flag);
    static int smallIconSize()
    {
        return QApplication::style()->pixelMetric(QStyle::PM_SmallIconSize);
    }
    static int titleBarHeight()
    {
        return QApplication::style()->pixelMetric(QStyle::PM_TitleBarHeight);
    }

signals:
    void isFullScreenModeChanged(bool fullScreenMode);

private:
    bool m_isFullScreenMode = false;
    bool m_wasWindowMaximized;
    MainWindow * m_window;
};

#endif //APPWINDOWMANAGER_H
