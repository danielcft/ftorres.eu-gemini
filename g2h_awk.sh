#!/usr/bin/env bash

# Run tree in gemini directory and get all gmi files in a list.
# We remove the .gmi extension in the names.
cd gemini && tree -fi | sed -n '/\.gmi$/{s///;s+^\./++;p}' > gmi_list

# An array of the files from above.
readarray -t options < gmi_list

# For each member of the array, we convert $i.gmi to $i.html
for i in "${options[@]}"; do
    awk -f ../g2h.awk "$i".gmi | sed 's/.gmi/.html/g;s/=> gemini/\n=> gemini/g' > html/"$i".html
done

#rsync -a html/ ../html/
