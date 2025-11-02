#! /bin/sh
set -e
scriptDir="$( dirname $( readlink -f "$0" ) )"

TEMP_DIR="/tmp"
DIARY_REMOTE_URL="/home/maxbundy/git/diary-memento-bare"
THEME="diary"
GIT_REMOTE="diary"
MAIN_BRANCH="main"
GIT_DIR="$TEMP_DIR/diary"
DB_DIR="$GIT_DIR/.db"

YEAR="$( date '+%+4Y' )"
MONTH="$( date '+%m' )"
DAY="$( date '+%d' )"
DAY=01

#entryFilename="$( date '+%F' )-$( hostname )-$( git rev-parse --short HEAD ).txt"
entryFilename="$YEAR-$MONTH-$DAY-$THEME.txt"
entryDir="$DB_DIR/$YEAR/$MONTH"
entryFilepath="$entryDir/$entryFilename"
todayBranch="daily-$YEAR-$MONTH-$DAY"

