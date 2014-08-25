base=`pwd`

for i in phrase_based/en-*; do
        pair=`echo $i | cut -d '/' -f2`;
        src=`echo $pair | cut -d '-' -f1`
        tgt=`echo $pair | cut -d '-' -f2`;
	cat $i/all-bleu-score >> combined-bleus
done;


for i in phrase_based/*-en; do
        pair=`echo $i | cut -d '/' -f2`;
        src=`echo $pair | cut -d '-' -f1`
        tgt=`echo $pair | cut -d '-' -f2`;
        cat $i/all-bleu-score >> combined-bleus
done;

