#!/bin/sh
# Test basic functionality

set -e

proram=$0
TMPDIR=${TMPDIR:-/tmp}
BASE=tmp.$$
TMPBASE=${TMPDIR%/}/$BASE
CURDIR=.

case "$0" in
  */*)
        CURDIR=$(cd "${0%/*}" && pwd)
        ;;
esac

AtExit ()
{
    rm -rf "$TMPBASE"
}

Run ()
{
    echo "$*"
    shift
    eval "$@"
}

trap AtExit 0 1 2 3 15

# #######################################################################

mkdir -p "$TMPBASE"
cd "$TMPBASE"

file1="example.1"
file2="example.2"
link="example.3"

echo test > "$file1"
echo test > "$file2"
ln -s "$file2" "$link"


Run "%% TEST files:" duff -e "$file1" "$file2"
Run "%% TEST symlinks:" duff -L "$file2" "$link"

Run "%% TEST directory:" duff -r "."

# End of file
