#!/bin/bash
#
echo "Started..."
#Started...
#
# special variable $# is the number of arguments
if [ $# -lt 2 ] ; then
    echo 'Call ./<script> <url> <cert secret>'
    exit 1
fi
#
downloadUrl="$1"
echo "downloadUrl: $downloadUrl"
#
certSecret="$2"
echo "certSecret: $certSecret"
#
cd ~
rm -r ${HOME}/gtfs
mkdir -p ${HOME}/gtfs
curl --request GET --url $downloadUrl --header "Accept-Encoding: gzip, deflate"  --cert-type P12 --cert $HOME/certificate.p12:"$certSecret" --output ${HOME}/gtfs/gtfs.gz
#
echo "Done."
#done.
