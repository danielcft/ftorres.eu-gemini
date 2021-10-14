#!/bin/sh

cd gemini || exit
mkdir -p html/pages/
cp -r resources html/
tree -fi | sed -n '/\.gmi$/{s///;s+^\./++;p}' >gmi_list

# For each filename, convert $FILENAME.gmi to $FILENAME.html
while IFS= read -r FILENAME; do
	touch html/"$FILENAME".html
	awk -f ../g2h.awk "$FILENAME".gmi | sed -E "s/\/(.*)\.gmi/\/\1.html/g;s/=> gemini/\n=> gemini/g" >html/"$FILENAME".html
done <gmi_list

rsync -a html/ ../html/
rm -rf html
rm gmi_list
