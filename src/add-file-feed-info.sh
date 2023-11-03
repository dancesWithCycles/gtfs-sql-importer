#!/bin/bash
#
echo "Started..."
#Started...
#
# special variable $# is the number of arguments
if [ $# -lt 2 ] ; then
    echo 'Call ./<script> <gtfs zip file path> <gtfs zip file name>'
    exit 1
fi
#
gtfsZipFilePath="$1"
echo "gtfsZipFilePath: $gtfsZipFilePath"
gtfsZipFileName=${gtfsZipFilePath}/"$2"
echo "gtfsZipFileName: $gtfsZipFileName"
#
unzipDir=${gtfsZipFilePath}/unzip
echo "unzipDir: $unzipDir"
rm -rf $unzipDir
mkdir -p $unzipDir
unzip -qq -d $unzipDir $gtfsZipFileName
#
# add file feed_info.txt if not present so that gtfs-sql-importer git repo is not complaining
#
if [ $(unzip -Z -1 "$gtfsZipFileName" | grep feed_info.txt) ];
then
    echo "feed_info.txt present"
else
    echo "feed_info.txt NOT present"
    # (): replaces the shell without creating a new process
    BASEDIR=$(dirname $0)
    echo "BASEDIR: ${BASEDIR}"
    (sh ./${BASEDIR}/feed_info.sh $unzipDir)
    zip -jr ${gtfsZipFileName}-feed_info.zip ${unzipDir}
fi
#
echo "Done."
#done.
