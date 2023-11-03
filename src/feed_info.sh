#!/bin/bash
#
echo "Started..."
#Started...
#
# special variable $# is the number of arguments
if [ $# -lt 1 ]; then
    echo 'Call ./<script> <work dir>'
    exit 1
fi
#
file=${1}/feed_info.txt
echo "file: "
echo $file
rm $file
touch ${file}
head='feed_publisher_name,feed_publisher_url,feed_lang,feed_start_date,feed_end_date,feed_version'
echo "head: "
echo $head
echo $head >> ${file}
date=$(date +"%Y%m%d")
feed_publisher_name=DELFI
feed_publisher_url=https://delfi.de
feed_lang=de
feed_start_date=$date
echo "start_date: ${feed_start_date}"
feed_end_date=$((${date}+9999))
echo "end_date: ${feed_end_date}"
feed_version=1
entry=${feed_publisher_name},${feed_publisher_url},${feed_lang},${feed_start_date},${feed_end_date},${feed_version}
echo "entry: "
echo $entry
echo $entry >> ${file}
#
echo "Done."
#done.
