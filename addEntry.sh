#! /bin/sh
set -e
scriptDir="$( dirname $( readlink -f "$0" ) )"

DIARY_REMOTE_URL="/home/maxbundy/git/diary-memento-bare"
THEME="diary"
GIT_REMOTE="diary"
MAIN_BRANCH="main"
GIT_DIR="/tmp/diary"
DB_DIR="$GIT_DIR/.db"

YEAR="$( date '+%+4Y' )"
MONTH="$( date '+%m' )"
DAY="$( date '+%d' )"
#DAY=04

#entryFilename="$( date '+%F' )-$( hostname )-$( git rev-parse --short HEAD ).txt"
entryFilename="$YEAR-$MONTH-$DAY-$THEME.txt"
entryDir="$DB_DIR/$YEAR/$MONTH"
entryFilepath="$entryDir/$entryFilename"
todayBranch="daily-$YEAR-$MONTH-$DAY"

>&2 echo " > 1- Init diary repo ..."
test -d "$GIT_DIR" || git clone -o "$GIT_REMOTE" "$DIARY_REMOTE_URL" "$GIT_DIR"
cd "$GIT_DIR"
#git remote add "$GIT_REMOTE" "$DIARY_REMOTE_URL" || true
mkdir -p "$DB_DIR"

git fetch --all --prune

# 1- Squash & Merge all daily branches
>&2 echo " > 2- Squash merge passed branches ..."
git switch "$MAIN_BRANCH" || git checkout -b "$MAIN_BRANCH"
for branch in $( git branch --format='%(refname:short)' | sort | grep -v "$MAIN_BRANCH" | grep -v "$todayBranch" | grep -v "main" ); do
	>&2 echo "squash merge $branch branch ..."
	# May need to use --autostash ?
	#git rebase --autosquash "$MAIN_BRANCH"
	git merge --squash "$branch"
	git add "$DB_DIR"
	git commit -m "Squashed entries for $branch"
	git branch -D "$branch"
	git push "$GIT_REMOTE" -d "$branch"
done

>&2 echo " > 3- Switch on today branch ..."
git switch "$todayBranch" || git checkout -b "$todayBranch" "$MAIN_BRANCH" || git checkout -b "$todayBranch"
#git switch -C "$todayBranch" # Seems bad because it reset the branch ?

mkdir -p "$entryDir"
#echo "\n" >> "$entryFilepath"
#vi -c 'startinsert' "$entryFilepath"
vi "$entryFilepath"

>&2 echo " > 4- Commit and Push changes ..."
git add "$entryFilepath"
msg="Added entry $entryFilename"
#git commit --fixup -m "$msg" || git commit -m "$msg"
git commit -m "$msg"
git push "$GIT_REMOTE" "$todayBranch"

