
echo "Usage: $0 <startCommitSHA> <startCommitSHA>\n\n"

outputFile="out.html"
rm $outputFile && touch $outputFile
# 3b9aea39c7..37c07544408b

echo "Start from Commit SHA: $1\n"
echo "End at Commit SHA: $2"

`echo "<html><head><style>td{white-space: pre;}</style></head><body><table border=1>" >> $outputFile`

git log --pretty='format:' --name-only $1..$2 | sort -u | while read line
do
    if [ -n "${line}" ]; then
        `echo "<tr>" >> $outputFile`
        `echo "<td>File: ($line)</td>" >> $outputFile`
        `echo "<td>" >> $outputFile`
        git log --pretty=oneline  --abbrev-commit $1..$2  -- $line >> $outputFile
        `echo "</td></tr>" >> $outputFile`
        
        # --all --full-history
    fi
done
`echo "</table></body></html>" >> $outputFile`

echo "\n\nSaved to $outputFile"