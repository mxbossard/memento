#! /bin/sh
set -e
scriptDir="$( dirname $( readlink -f "$0" ) )"

tmpDir="$( mktemp -d "/tmp/test-memento.XXXXXX" )"
cd "$tmpDir"

# Setup tmp repo
dbRepo="memento-bare"
git init --bare -b main "$dbRepo"
export DIARY_GIT_REPO_URL="$tmpDir/$dbRepo"
export GIT_LOCAL_REPO="$tmpDir/memento"

# Populate tmp repo
export DIARY_DATE="@$( date '+%s' -d "2025-10-03" )"
$scriptDir/addEntry.sh "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

export DIARY_DATE="@$( date '+%s' -d "2025-10-03" )"
2>/dev/null 1>&2 $scriptDir/addEntry.sh "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

export DIARY_DATE="@$( date '+%s' -d "2025-10-05" )"
2>/dev/null 1>&2 $scriptDir/addEntry.sh "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

export DIARY_DATE="@$( date '+%s' -d "2025-10-07" )"
2>/dev/null 1>&2 $scriptDir/addEntry.sh "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

export DIARY_DATE="@$( date '+%s' -d "2025-10-09" )"
2>/dev/null 1>&2 $scriptDir/addEntry.sh "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

>&2 echo "> ### Test visu ..."
$scriptDir/visu.sh -c

cd
rm -rf -- "$tmpDir"
