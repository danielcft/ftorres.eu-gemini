#! /bin/awk -f 
BEGIN{
 title="ftorres.eu"
 stylesheet="style.css"
 inpre=false;
 inul=false;
 print"<!DOCTYPE html>\n<html lang='en'>\n<head>"
 printf("<title>%s</title>\n", title)
 print"<meta name='viewport' content='width=device-width, initial-scale=1' />"
 print"<meta charset='UTF-8'>"
 printf("<link rel='stylesheet' type='text/css' href='%s'>", stylesheet)
 print"</head>\n<body>"
}

# h1, h2, h3
(!inpre) && /^# /{printf("<h1>%s</h1>\n",substr($0,3));next;}
(!inpre) && /^## /{printf("<h2>%s</h2>\n",substr($0,4));next;}
(!inpre) && /^### /{printf("<h3>%s</h3>\n",substr($0,5));next;}

# pre 
/^```$/{printf("<%spre>\n",inpre?"/":"");inpre = !inpre;next}
(inpre){printf("%s\n",$0);}

# ul, li
(!inpre && !inul && $1 ~ /^\*/){$1="";inul=!inul;printf("<ul>\n<li>%s</li>\n",$0);next;}
(!inpre && inul && $1 ~ /^\*/){$1="";printf("<li>%s</li>\n",$0);next;}
(!inpre && inul && $1 !~ /^\*/){inul=!inul;printf("</ul>\n",$0);}

# a
(!inpre) && /^=>/{
   remx="";
   for(d=3;d <= NF;d++)
     remx=remx $(d) " ";
   printf("<a href=\"%s\">%s</a><br>\n",$2,remx);
   next
}

# blockquote
(!inpre) && /^> /{$1=""; printf("<blockquote>%s</blockquote>\n",$0);next;}

# paragraph
(!inpre){ if($0 ~ /^$/);else printf("<p>%s</p>\n",$0);}

END{print "</body>\n</html>"}
