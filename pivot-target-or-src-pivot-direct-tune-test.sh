base=`pwd`

for i in phrase_based/en-*; do
        pair=`echo $i | cut -d '/' -f2`;
        src=`echo $pair | cut -d '-' -f1`
        tgt=`echo $pair | cut -d '-' -f2`;
	for j in $i/moses-direct-plus-*.ini; do
       	        piv=`echo $j | cut -d '-' -f5 | cut -d '.' -f1 `;
		if [[ `grep "$piv-$tgt" completed-direct-pairs | wc -l` -le 0 ]]; then
	                echo "$piv-$tgt" >> completed-direct-pairs;
			pair=$piv-$tgt;
			src=$piv;
	               	mkdir $base/phrase_based/$pair/direct;
	                cd $base/phrase_based/$pair/direct;
                	~/tools/moses/scripts/training/mert-moses.pl ~/phrase-tables-LMs/corpora/$pair/tun.$src ~/phrase-tables-LMs/corpora/$pair/tun.$tgt ~/tools/moses/bin/moses ../moses.ini --mertdir ~/tools/moses/bin/ --rootdir ~/tools/moses/scripts/ -no-filter-phrase-table --batch-mira --return-best-dev --batch-mira-args '-J 100' --decoder-flags '-threads 4 -v 0';
			~/tools/moses/bin/moses -threads 4 -f mert-work/moses.ini < ~/phrase-tables-LMs/corpora/$pair/test.$src > translated.$tgt;
		        perl ~/tools/moses/scripts/generic/multi-bleu.perl ~/phrase-tables-LMs/corpora/$pair/test.$tgt < translated.$tgt > bleu-score;
	                cd $base;
		fi;
        done;
done

base=`pwd`

for i in phrase_based/*-en; do
        pair=`echo $i | cut -d '/' -f2`;
        src=`echo $pair | cut -d '-' -f1`
        tgt=`echo $pair | cut -d '-' -f2`;
        for j in $i/moses-direct-plus-*.ini; do
                piv=`echo $j | cut -d '-' -f5 | cut -d '.' -f1 `;
                if [[ `grep "$src-$piv" completed-direct-pairs | wc -l` -le 0 ]]; then
                        echo "$src-$piv" >> completed-direct-pairs;
                        pair=$src-$piv;
                        tgt=$piv;
                        mkdir $base/phrase_based/$pair/direct;
                        cd $base/phrase_based/$pair/direct;
                        ~/tools/moses/scripts/training/mert-moses.pl ~/phrase-tables-LMs/corpora/$pair/tun.$src ~/phrase-tables-LMs/corpora/$pair/tun.$tgt ~/tools/moses/bin/moses ../moses.ini --mertdir ~/tools/moses/bin/ --rootdir ~/tools/moses/scripts/ -no-filter-phrase-table --batch-mira --return-best-dev --batch-mira-args '-J 100' --decoder-flags '-threads 4 -v 0';
	                ~/tools/moses/bin/moses -threads 4 -f mert-work/moses.ini < ~/phrase-tables-LMs/corpora/$pair/test.$src > translated.$tgt;
        	        perl ~/tools/moses/scripts/generic/multi-bleu.perl ~/phrase-tables-LMs/corpora/$pair/test.$tgt < translated.$tgt > bleu-score;
                        cd $base;
                fi;
        done;
done

