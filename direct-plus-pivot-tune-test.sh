base=`pwd`

for i in phrase_based/en-*; do
        pair=`echo $i | cut -d '/' -f2`;
        src=`echo $pair | cut -d '-' -f1`
        tgt=`echo $pair | cut -d '-' -f2`;
        for j in $i/moses-direct-plus-*.ini; do
                piv=`echo $j | cut -d '-' -f5 | cut -d '.' -f1 `;
                mkdir $i/direct-plus-$piv;
                cd $i/direct-plus-$piv;
                echo "For pivot $piv";
                ~/tools/moses/scripts/training/mert-moses.pl ~/phrase-tables-LMs/corpora/$pair/tun.$src ~/phrase-tables-LMs/corpora/$pair/tun.$tgt ~/tools/moses/bin/moses ../moses-direct-plus-$piv.ini --mertdir ~/tools/moses/bin/ --rootdir ~/tools/moses/scripts/ -no-filter-phrase-table --batch-mira --return-best-dev --batch-mira-args '-J 100' --decoder-flags '-threads 4 -v 0';
		~/tools/moses/bin/moses -threads 4 -f mert-work/moses.ini < ~/phrase-tables-LMs/corpora/$pair/test.$src > translated.$tgt;
	        perl ~/tools/moses/scripts/generic/multi-bleu.perl ~/phrase-tables-LMs/corpora/$pair/test.$tgt < translated.$tgt > bleu-score;
                cd $base;
        done;
done

base=`pwd`

for i in phrase_based/*-en; do
        pair=`echo $i | cut -d '/' -f2`;
        src=`echo $pair | cut -d '-' -f1`
        tgt=`echo $pair | cut -d '-' -f2`;
        for j in $i/moses-direct-plus-*.ini; do
                piv=`echo $j | cut -d '-' -f5 | cut -d '.' -f1 `;
                mkdir $i/direct-plus-$piv;
                cd $i/direct-plus-$piv;
                echo "For pivot $piv";
                ~/tools/moses/scripts/training/mert-moses.pl ~/phrase-tables-LMs/corpora/$pair/tun.$src ~/phrase-tables-LMs/corpora/$pair/tun.$tgt ~/tools/moses/bin/moses ../moses-direct-plus-$piv.ini --mertdir ~/tools/moses/bin/ --rootdir ~/tools/moses/scripts/ -no-filter-phrase-table --batch-mira --return-best-dev --batch-mira-args '-J 100' --decoder-flags '-threads 4 -v 0';
                ~/tools/moses/bin/moses -threads 4 -f mert-work/moses.ini < ~/phrase-tables-LMs/corpora/$pair/test.$src > translated.$tgt;
                perl ~/tools/moses/scripts/generic/multi-bleu.perl ~/phrase-tables-LMs/corpora/$pair/test.$tgt < translated.$tgt > bleu-score;
                cd $base;
        done;
done

