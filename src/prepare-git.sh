#!/bin/bash
#
echo "Started..."
#Started...
#
rm -fr ${HOME}/git
mkdir -p ${HOME}/git && cd ${HOME}/git
git clone -b gtfs2sql https://github.com/dancesWithCycles/gtfs2sql.git
#
echo "Done."
#done.
