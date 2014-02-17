# 
# Do NOT Edit the Auto-generated Part!
# Generated by: spectacle version 0.27
# 

Name:       harbour-tweetian

# >> macros
# << macros

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}
Summary:    Tweetian is a feature-rich Twitter app for Symbian and Harmattan, powered by Qt/QML. It comes with a simple, native and amazing UI that will surely make you enjoy the Twitter experience on your smartphone.
Version:    2.0.0
Release:    1
Group:      Applications/Communications
License:    GPLv3
Source0:    %{name}-%{version}.tar.bz2
Source100:  harbour-tweetian.yaml
Requires:   qt5-qtlocation
Requires:   sailfishsilica-qt5
Requires:   qt5-qtdeclarative-import-location
Requires:   qt5-qtdeclarative-import-positioning
Requires:   qt5-qtsvg
Requires:   qt5-plugin-imageformat-gif
Requires:   qt5-qtsvg-plugin-imageformat-svg
BuildRequires:  pkgconfig(Qt5Svg)
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(sailfishapp)
BuildRequires:  pkgconfig(Qt5Location)
BuildRequires:  pkgconfig(Qt5Positioning)
BuildRequires:  desktop-file-utils

%description
Tweetian is a feature-rich Twitter app for Symbian and Harmattan, powered by Qt/QML. It comes with a simple, native and amazing UI that will surely make you enjoy the Twitter experience on your smartphone.


%prep
%setup -q -n %{name}-%{version}

# >> setup
# << setup

%build
# >> build pre
# << build pre

%qtc_qmake5 

%qtc_make %{?_smp_mflags}

# >> build post
# << build post

%install
rm -rf %{buildroot}
# >> install pre
# << install pre
%qmake5_install

# >> install post
# << install post

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
/usr/share/applications
/usr/share/icons/hicolor/86x86/apps
/usr/bin
%{_datadir}/applications/%{name}.desktop
%{_bindir}/%{name}
%{_datadir}/icons/hicolor/86x86/apps/%{name}.png
# >> files
# << files
