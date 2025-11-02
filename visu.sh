#! /bin/sh
set -e
scriptDir="$( dirname $( readlink -f "$0" ) )"

. "$scriptDir/_common.sh"

tmpDir="$( mktemp -d "$TEMP_DIR/diary.XXXXXX.dir" )"
cd "$tmpDir"
tmpFile="tmpFile.txt"

mkfifo diaryPipe
touch "$tmpFile"
tail -f "$tmpFile" 1> diaryPipe &
tailPid="$!"

{
	for yearDir in $( find "$DB_DIR" -type d -mindepth 1 -maxdepth 1 | sort -r ); do
		#>&2 echo "yearDir: $yearDir"
		for monthDir in $( find "$yearDir" -type d -mindepth 1 -maxdepth 1 | sort -r ); do
			#>&2 echo "monthDir: $monthDir"
			for file in $( find "$monthDir" -type f -name "*-diary.txt" | sort -r ); do
				#>&2 echo "file: $file"
				sleep 0.1
				filename="$( basename "$file" )"
				echo "----- $filename -----" >> "$tmpFile"
				cat "$file" >> "$tmpFile"
				echo >> "$tmpFile"
			done
		done
	done
	sleep 1
	kill "$tailPid"
} &

less 0< diaryPipe

#vi "$tmpFile"
#less "$tmpFile"

rm -rf "$TEMP_DIR/diary.*.dir"
