
echo "Usage: $0 <startCommitSHA> <startCommitSHA>\n\n"

rm out.txt && touch out.txt
# 3b9aea39c7..37c07544408b

echo "Start from Commit SHA: $1\n"
echo "End at Commit SHA: $2"

git log --pretty='format:' --name-only $1..$2 | sort -u | while read line
do
    if [ -n "${line}" ]; then
        `echo "\n\n\n\nFile: ($line)\n--------------------------------------------\n" >> out.txt`
        git log --pretty=oneline  --abbrev-commit  --all --full-history -- $line >> out.txt
    fi
done

echo "\n\nSaved to out.txt"