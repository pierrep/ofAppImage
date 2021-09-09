#!/bin/bash

if [ $# -lt 2 ]
  then
    echo "Usage: rename-appimage.sh appname appdir"
    echo "appname = your new AppImage name"
    echo "appdir = the directory containing the AppImage directory structure"
    exit 1
fi


APPNAME=$1
APPDIR=$2
TARGETDIR="${APPNAME}-dir"


if   [ ! -d "${APPDIR}" ]; then
	echo "second argument is not a valid directory"
	exit 1
fi

if   [ -d "${TARGETDIR}" ]; then
	echo "${TARGETDIR} exists, please remove it then re-run this script"
	exit 1
fi

rm -rf ${TARGETDIR}
cp -r ${APPDIR} ${TARGETDIR}

cd $TARGETDIR
sed -i "s/APPNAME=.*/APPNAME=${APPNAME}/" AppRun

APPNAMEUPPER=$(echo $APPNAME | tr 'a-z' 'A-Z')

for file in *.desktop;
do
	echo "renaming ${file} ..."
	rm $file
	mv usr/share/applications/$file usr/share/applications/${APPNAME}.desktop
	ln -s usr/share/applications/${APPNAME}.desktop ${APPNAME}.desktop 
	sed -i "s/Icon=.*/Icon=${APPNAME}/" usr/share/applications/${APPNAME}.desktop
	sed -i "s/Name=.*/Name=${APPNAME}/" usr/share/applications/${APPNAME}.desktop
	sed -i "s/Comment=.*/Comment=\"${APPNAME} application\"/" usr/share/applications/${APPNAME}.desktop
	sed -i "s/Exec=.*/Exec=${APPNAME}/" usr/share/applications/${APPNAME}.desktop
	sed -i "s/StartupWMClass=.*/StartupWMClass=${APPNAMEUPPER}/" usr/share/applications/${APPNAME}.desktop
done

for file in *.svg;
do
	echo "renaming ${file} ..."
	rm $file
	mv usr/share/icons/hicolor/scalable/apps/$file usr/share/icons/hicolor/scalable/apps/${APPNAME}.svg
	ln -s usr/share/icons/hicolor/scalable/apps/${APPNAME}.svg ${APPNAME}.svg
	rm .DirIcon
	ln -s ${APPNAME}.svg .DirIcon
done




