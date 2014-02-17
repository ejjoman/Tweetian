/*
    Copyright (C) 2012 Dickson Leong
    This file is part of Tweetian.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: tabPageHeader

    // listView must be Silica SlideshowView and have:
    // VisualItemModel as model
    // function - moveToColumn(index)
    // Each children of VisualItemModel must have:
    // properties - busy (bool) and unreadCount (int)
    // method - positionAtTop()
    property SlideshowView listView: null
    property variant iconArray: []

    anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
    height: Theme.itemSizeSmall //constant.headerHeight

    Image {
        id: background
        fillMode: Image.TileVertically
        anchors.fill: parent
        source: "image://theme/graphic-gradient-home-top"

        //source: "image://theme/graphic-gradient-edge"

    }

    Row {
        anchors.fill: parent

        Repeater {
            id: sectionRepeater
            model: iconArray
            delegate: BackgroundItem {
                id: tabDelegate

                readonly property bool isActive: listView.currentIndex === index
                readonly property int unreadCount: listView.model.children[index].unreadCount ? listView.model.children[index].unreadCount : 0

                width: tabPageHeader.width / sectionRepeater.count
                height: tabPageHeader.height

                Rectangle {
                    color: Theme.secondaryColor
                    radius: 5

                    anchors {
                        top: parent.top;
                        topMargin: Theme.paddingMedium
                        right: parent.right;
                        rightMargin: Theme.paddingSmall
                    }

                    visible: tabDelegate.unreadCount > 0

                    width: count.width + Theme.paddingSmall
                    height: count.height - Theme.paddingSmall

                    Label {
                        id: count
                        anchors.centerIn: parent
                        font.pixelSize: Theme.fontSizeExtraSmall  //Theme.fontSizeSmall
                        //color: Theme.highlightColor

                        text: tabDelegate.unreadCount > 0 ? tabDelegate.unreadCount : ""


                    }
                }

                Image {
                    id: icon
                    //height: 64
                    //width: height
                    anchors.centerIn: parent
                    source: tabDelegate.isActive ? modelData + "?" + Theme.highlightColor : modelData
                    smooth: true
                }



                Loader {
                    anchors.fill: parent
                    sourceComponent: listView.model.children[index].busy ? busyIndicator : undefined
                    Component {
                        id: busyIndicator

                        Item {
                            anchors.fill: parent

                            Rectangle {
                                id: loadingBackground
                                anchors.fill: parent
                                color: "black"
                                opacity: 0

                                Behavior on opacity { NumberAnimation { duration: 250 } }

                                Component.onCompleted: opacity = 0.5
                            }

                            BusyIndicator {
                                anchors.centerIn: parent
                                running: true
                                height: tabPageHeader.height - Theme.paddingLarge
                                width: height
                            }
                        }


                    }

                }

                onClicked: isActive ? listView.currentItem.positionAtTop()
                                    : listView.currentIndex = index

            }
        }
    }

    Rectangle {
        id: currentSectionIndicator
        anchors.top: parent.top
        color: Theme.highlightColor
        height: constant.paddingSmall
        width: tabPageHeader.width / sectionRepeater.count
        x: listView.currentIndex * width

        Behavior on x {
            NumberAnimation {
                duration: 100
            }
        }
    }
}
