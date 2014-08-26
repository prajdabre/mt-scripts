export LANG=en_IN
sed -i 's/\([_()\/?।,!;:-]\)/ \1 /g' $1 | sed "s/['‘’]/ ' /g"| sed "s/[\"“”]/ \" /g" | sed "s/\./ \. /g" | sed "s/[ ][ ]*/ /g" | sed "s/^ //g" | sed "s/ $//g"
