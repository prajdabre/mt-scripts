base=`pwd`

for i in phrase_based/*-en; do
        pair=`echo $i | cut -d '/' -f2`;
        src=`echo $pair | cut -d '-' -f1`
        tgt=`echo $pair | cut -d '-' -f2`;
        mkdir $i/comboall;
        cd $i/comboall;
        echo "Doing mert on pair $i";
        ~/tools/moses/scripts/training/mert-moses.pl ~/phrase-tables-LMs/corpora/$pair/tun.$src ~/phrase-tables-LMs/corpora/$pair/tun.$tgt ~/tools/moses/bin/moses ../moses-comboall.ini --mertdir ~/tools/moses/bin/ --rootdir ~/tools/moses/scripts/ -no-filter-phrase-table --batch-mira --return-best-dev --batch-mira-args '-J 100' --decoder-flags '-threads 4 -v 0';
	echo "Testing pair $i";
        ~/tools/moses/bin/moses -threads 4 -f mert-work/moses.ini < ~/phrase-tables-LMs/corpora/$pair/test.$src > translated.$tgt;
        perl ~/tools/moses/scripts/generic/multi-bleu.perl ~/phrase-tables-LMs/corpora/$pair/test.$tgt < translated.$tgt > bleu-score;
        echo "When all is combined for pair: $pair" >> ../combo-bleu-score;
        cat bleu-score >> ../combo-bleu-score;

        cd $base;
done

