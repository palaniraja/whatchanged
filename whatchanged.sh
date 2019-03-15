
echo "===========================================\n"
echo "Usage: $0 <startCommitSHA> <startCommitSHA>\n"
echo "===========================================\n\n\n"

outputFile="diff.html"
rm $outputFile && touch $outputFile
# 3b9aea39c7..37c07544408b
diffString=""
index=0

echo "Start from Commit SHA: $1\n"
echo "End at Commit SHA: $2"

`cat head.html >> $outputFile`

echo "<p>Files changed between <b>$1</b> and <b>$2</b></p>"  >> $outputFile
echo "<table border=1 style='border-collapse: collapse;'>" >> $outputFile
git log --pretty='format:' --name-only $1..$2 | uniq | while read line
do
    if [ -n "${line}" ]; then
        `echo "<tr>" >> $outputFile`
        `echo "<td> <h3>File: ($line)</h3>" >> $outputFile`
        `echo "<p>" >> $outputFile`
        
        git log --pretty="[%h] %s <br />" $1..$2  -- $line >> $outputFile
        # --all --full-history
        
        `echo "</p><textarea class='rawDiff' id='rawDiff$index'>" >> $outputFile`
        
        diffString=$(git diff $1..$2  -- $line)
        `echo "$diffString</textarea><div class='outDiff' id='outDiff$index'>{{loading diff...}}</div></td></tr>" >> $outputFile`
        
        index=$((index + 1))

        # TODO: need to fix why $index is different on outside of loop, reseting on everyfile now to get the job done.
        `echo "<script type='text/javascript'>var fileCount=$index;//test</script>" >> $outputFile`
    fi
done


`cat tail.html >> $outputFile`

echo "\n\nSaved to $outputFile"
