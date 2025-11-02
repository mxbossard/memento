#! /bin/sh
set -e
scriptDir="$( dirname $( readlink -f "$0" ) )"

. "$scriptDir/_common.sh"

entryMsg="$1"

>&2 echo " > 1- Init diary repo ..."
test -d "$GIT_LOCAL_REPO" || git clone -o "$GIT_REMOTE" "$DIARY_GIT_REPO_URL" "$GIT_LOCAL_REPO"
cd "$GIT_LOCAL_REPO"
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

if [ -n "$entryMsg" ]; then
	if [ -f "$entryFilepath" ]; then
		echo "" >> "$entryFilepath"
	fi 
	echo "$entryMsg" >> "$entryFilepath"
else
	vi "$entryFilepath"
fi

>&2 echo " > 4- Commit and Push changes ..."
git add "$entryFilepath"
msg="Added entry $entryFilename"
#git commit --fixup -m "$msg" || git commit -m "$msg"
git commit -m "$msg"
git push "$GIT_REMOTE" "$todayBranch"

