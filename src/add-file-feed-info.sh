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
unzipDir=${gtfsZipFilePath}/unzip
echo "unzipDir: $unzipDir"
baseDir=$(dirname $0)
echo "baseDir: $baseDir"
# decompress gtfs feed
gzip -d ${HOME}/gtfs/gtfs.gz
# extract gtfs archive
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
    (bash ./${baseDir}/feed_info.sh $unzipDir)
    zip -jr ${gtfsZipFileName}-feed_info.zip ${unzipDir}
fi
#
echo "Done."
#done.
