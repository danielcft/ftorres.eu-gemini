#!/bin/sh

rsync -a gemini/ ftorres.eu:~/gemini
rsync -a html/ ftorres@rawtext.club:~/public_html/
rsync -a html/ ftorres.eu:/var/www/html/
