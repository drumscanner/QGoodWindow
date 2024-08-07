/*
The MIT License (MIT)

Copyright © 2018-2024 Antonio Dias (https://github.com/antonypro)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Window
import appWindowManager

Rectangle
{
    visible: true
    focus: true

    color: "#303030"

    property string windowIcon
    property string windowIconGrayed
    property string windowTitle
    property bool isMaximized
    property bool isVisible
    property bool isActive
    property bool isTitleBarVisible

    function setButtonState(button, state)
    {
        switch (button)
        {
        case "minBtn":
            switch (state)
            {
            case "hover_enter":
                minBtn.hoverEnter()
                break;
            case "hover_leave":
                minBtn.hoverLeave()
                break;
            case "button_press":
                minBtn.buttonPress()
                break;
            case "button_release":
                minBtn.buttonRelease()
                break;
            default:
                break;
            }
            break;
        case "maxBtn":
            switch (state)
            {
            case "hover_enter":
                maxBtn.hoverEnter()
                break;
            case "hover_leave":
                maxBtn.hoverLeave()
                break;
            case "button_press":
                maxBtn.buttonPress()
                break;
            case "button_release":
                maxBtn.buttonRelease()
                break;
            default:
                break;
            }
            break;
        case "clsBtn":
            switch (state)
            {
            case "hover_enter":
                clsBtn.hoverEnter()
                break;
            case "hover_leave":
                clsBtn.hoverLeave()
                break;
            case "button_press":
                clsBtn.buttonPress()
                break;
            case "button_release":
                clsBtn.buttonRelease()
                break;
            default:
                break;
            }
            break;
        default:
            break;
        }
    }

    Shortcut {
        sequence: "F"
        onActivated: appWindowManager.toggleFullScreen()
    }

    AppWindowManager {
        id: appWindowManager

        function toggleFullScreen() {
            isFullScreenMode = !isFullScreenMode;
        }
    }

    Column
    {
        anchors.fill: parent

        Rectangle
        {
            id: titlebar
            color: "#222222"
            width: parent.width
            height: appWindowManager.titleBarHeight
            z: 1
            visible: isTitleBarVisible

            Rectangle
            {
                id: windowIconRect
                x: 0
                y: 0
                width: appWindowManager.titleBarHeight
                height: parent.height
                color: "transparent"

                Image
                {
                    id: windowIconImage
                    anchors.centerIn: parent
                    width: appWindowManager.smallIconSize
                    height: appWindowManager.smallIconSize
                    smooth: true
                    source: isTitleBarVisible ? (isActive ? windowIcon : windowIconGrayed) : ""
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton
                    onClicked: {
                        console.info("OnClicked context menu")
                        windowMenu.popup()
                    }
                }

                Menu {
                    id: windowMenu
                    MenuItem {
                        text: "Restore"
                    }
                    MenuItem {
                        text: "Minimize"
                    }
                    MenuItem {
                        text: "Maximize"
                    }
                    MenuItem {
                        text: "Close"
                    }
                }
            }

            Text
            {
                id: windowTitleText
                x: windowIconRect.width
                y: 0
                anchors.left: windowIconRect.right
                anchors.right: minBtn.left
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Qt.AlignCenter
                color: isActive ? windowTitle.color = "#FFFFFF" : windowTitle.color = "#AAAAAA"
                elide: Text.ElideRight
                text: windowTitle
            }

            CaptionButton
            {
                id: minBtn
                x: parent.width - clsBtn.width - maxBtn.width - width
                y: 0
                width: parent.height
                height: parent.height
                buttonColor: "#009900"
                buttonColorPressed: "#005500"
                imgSource: isTitleBarVisible ? loadPixmapToString(":/icons/minimize.svg") : ""
            }

            CaptionButton
            {
                id: maxBtn
                x: parent.width - clsBtn.width - width
                y: 0
                width: parent.height
                height: parent.height
                buttonColor: "#999900"
                buttonColorPressed: "#555500"
                imgSource: isTitleBarVisible ? (!isMaximized ? loadPixmapToString(":/icons/maximize.svg") :
                                                               loadPixmapToString(":/icons/restore.svg")) : ""
            }

            CaptionButton
            {
                id: clsBtn
                x: parent.width - width
                y: 0
                width: parent.height
                height: parent.height
                buttonColor: "#FF0000"
                buttonColorPressed: "#990000"
                imgSource: isTitleBarVisible ? loadPixmapToString(":/icons/close.svg") : ""
            }
        }

        Page
        {
            id: contents
            background: Rectangle {
                anchors.fill: parent
            }

            width: parent.width
            height: parent.height - (titlebar.visible ? titlebar.height : 0)

            Rectangle {
                id: bigButton
                color: "#00FF00"
                anchors.margins: 30
                anchors.fill: parent

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        appWindowManager.toggleFullScreen()
                    }
                }
            }

            Connections {
                target: appWindowManager

                function onIsFullScreenModeChanged(result) {
                    bigButton.color = result ? "#FF0000" : "#00FF00"
                }
            }
        }
    }
}
