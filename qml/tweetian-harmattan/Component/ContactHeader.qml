import QtQuick 2.0
import Sailfish.Silica 1.0
import ".."

Item {
    id: headerItem
    property variant user: ({})

    property real _headerHeight: Theme.itemSizeLarge * 3 + Theme.paddingMedium

    anchors {
        left: parent.left;
        right: parent.right
    }

    height: _headerHeight

    Rectangle {
        anchors.fill: parent
        color: Theme.highlightBackgroundColor
        opacity: 0.1
        visible: !headerImage.visible
    }


    Image {
        id: headerImage
        anchors.fill: parent
        cache: false
        fillMode: Image.PreserveAspectCrop
        clip: true
        source: {
            if (user.profileBannerUrl)
                return user.profileBannerUrl.concat(userPage.isPortrait ? "/mobile_retina" : "/web_retina")
            else
                return undefined;
        }

        opacity: status == Image.Ready ? 0.4 : 0.0
        visible: source

        onStatusChanged: if (status == Image.Loading) fadeAnim.enabled = true

        Behavior on opacity {
            id: fadeAnim;
            enabled: false;
            FadeAnimation {}
        }
    }

    Image {
        id: profileImage
        anchors {
            left: parent.left
            leftMargin: Theme.paddingLarge
            bottom: parent.bottom
            bottomMargin: Theme.paddingLarge
        }

        height: screen.width / 3
        width: height
        cache: false
        fillMode: Image.PreserveAspectCrop
        source: user.profileImageUrl ? user.profileImageUrl.replace("_normal", "") : ""

        MouseArea {
            anchors.fill: parent

            onClicked: {
                pageStack.push(Qt.resolvedUrl("../TweetImage.qml"), {
                                   imageUrl: profileImage.source
                               })
            }
        }
    }

    Label {
        id: descriptionText
        anchors {
            left: profileImage.right
            leftMargin: Theme.paddingLarge
            right: parent.right
            rightMargin: Theme.paddingLarge
            bottom: parent.bottom
            bottomMargin: Theme.paddingLarge
        }

        maximumLineCount: 6
        wrapMode: Text.Wrap
        font.pixelSize: Theme.fontSizeExtraSmall
        text: user.description || ""
    }

//    PageHeader {
//        title: user.name || ""
//    }

    Label {
        id: nameLabel

        anchors {
            top: parent.top
            topMargin: Theme.paddingLarge
            right: parent.right
            rightMargin: Theme.paddingLarge
        }

        width: Math.min(screen.width * 0.7, contentWidth)

        font {
            family: Theme.fontFamilyHeading
            pixelSize: Theme.fontSizeLarge
        }
        horizontalAlignment: Text.AlignLeft
        truncationMode: TruncationMode.Fade
        color: Theme.highlightColor
        text: user.name || ""
    }

    Label {
        id: screenNameText

        anchors {
            top: nameLabel.bottom
            topMargin: Theme.paddingSmall
            right: parent.right
            rightMargin: Theme.paddingLarge
        }

        width: Math.min(screen.width * 0.7, contentWidth)
        opacity: 0.6
        font {
            family: Theme.fontFamilyHeading
            pixelSize: Theme.fontSizeExtraSmall
        }

        horizontalAlignment: Text.AlignLeft
        truncationMode: TruncationMode.Fade
        color: Theme.highlightColor
        text: user.screenName ? "@" + user.screenName : ""
    }

    /*

    Item {
        id: headerTopItem
        anchors { left: parent.left; right: parent.right }
        height: childrenRect.height

        Rectangle {
            id: profileImageContainer
            anchors { right: parent.right; top: parent.top; margins: constant.paddingMedium }
            width: profileImage.width + (border.width / 2); height: width
            color: "black"
            border.width: 2
            border.color: profileImageMouseArea.pressed ? constant.colorTextSelection : constant.colorMid



            MouseArea {
                id: profileImageMouseArea
                anchors.fill: parent
                onClicked: {
                    var prop = { imageUrl: user.profileImageUrl.replace("_normal", "") }
                    pageStack.push(Qt.resolvedUrl("TweetImage.qml"), prop)
                }
            }
        }

        Text {
            id: userNameText
            anchors {
                top: parent.top
                left: parent.left
                right: profileImageContainer.left
                margins: constant.paddingMedium
            }
            font.bold: true
            font.pixelSize: constant.fontSizeMedium
            font.family: Theme.fontFamily
            color: "white"
            style: Text.Raised
            styleColor: "black"
            text: user.name || ""
            horizontalAlignment: Text.AlignRight
        }

        Text {
            id: screenNameText
            anchors {
                top: userNameText.bottom
                right: profileImageContainer.left; rightMargin: constant.paddingMedium
                left: parent.left; leftMargin: constant.paddingMedium
            }
            font.pixelSize: constant.fontSizeMedium
            font.family: Theme.fontFamily
            color: "white"
            style: Text.Raised
            styleColor: "black"
            text: user.screenName ? "@" + user.screenName : ""
            horizontalAlignment: Text.AlignRight

        }
    }

    Text {
        id: descriptionText
        anchors {
            left: parent.left
            right: parent.right
            top: headerTopItem.bottom
            bottom: parent.bottom
            margins: constant.paddingMedium
        }
        wrapMode: Text.Wrap
        elide: Text.ElideRight
        maximumLineCount: userPage.isPortrait ? 5 : 4 // TODO: remove hardcoded value
        font.pixelSize: constant.fontSizeSmall
        font.family: Theme.fontFamily
        verticalAlignment: Text.AlignBottom
        color: "white"
        style: Text.Raised
        styleColor: "black"
        text: user.description || ""
    } */
}
