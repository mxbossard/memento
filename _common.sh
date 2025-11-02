#! /bin/sh
set -e
scriptDir="$( dirname $( readlink -f "$0" ) )"

TEMP_DIR="/tmp"
DIARY_GIT_REPO_URL="${DIARY_GIT_REPO_URL:-/home/maxbundy/git/diary-memento-bare}"
GIT_LOCAL_REPO="${GIT_LOCAL_REPO:-$TEMP_DIR/diary}"
THEME="diary"
GIT_REMOTE="diary"
MAIN_BRANCH="main"
DB_DIR="$GIT_LOCAL_REPO/.db"

DIARY_DATE="${DIARY_DATE:-}"
YEAR="$( date -d "$DIARY_DATE" '+%+4Y' )"
MONTH="$( date -d "$DIARY_DATE" '+%m' )"
DAY="$( date -d "$DIARY_DATE" '+%d' )"

#entryFilename="$( date '+%F' )-$( hostname )-$( git rev-parse --short HEAD ).txt"
entryFilename="$YEAR-$MONTH-$DAY-$THEME.txt"
entryDir="$DB_DIR/$YEAR/$MONTH"
entryFilepath="$entryDir/$entryFilename"
todayBranch="daily-$YEAR-$MONTH-$DAY"

