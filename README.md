# gh-issue-bulk
Bulk-create GitHub issues from a CSV.

## CSV format
First line is header; fields: `title,body,labels`
- To add labels, put them in the `title` field after a `|`, e.g.: `my title|bug,good first issue`
- Use `\n` in body to insert new lines.

## Example
```csv
title,body,labels
docs: improve README|docs,good first issue,"Please add install section\nAlso add badges."
bug: crash on empty input|bug,"\`--in\` without files should print help and exit 2"
```

## Run
```bash
chmod +x bulk-issues.sh
./bulk-issues.sh yourname/yourrepo issues.csv
```
