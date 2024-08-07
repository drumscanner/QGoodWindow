//
// Created by sergei on 7/30/24.
//

#include "AppWindowManager.h"
#include "mainwindow.h"

AppWindowManager::AppWindowManager()
{
}

void AppWindowManager::setIsFullScreenMode(bool flag)
{
    if (flag != m_isFullScreenMode)
    {
        auto * window = qobject_cast<MainWindow *>(QApplication::activeWindow());
        if (flag)
        {
            m_wasWindowMaximized = window->isMaximized();
            window->showFullScreen();
        }
        else
        {
            m_wasWindowMaximized ? window->showMaximized() : window->showNormal();
        }
        m_isFullScreenMode = flag;
        emit isFullScreenModeChanged(m_isFullScreenMode);
    }
}
