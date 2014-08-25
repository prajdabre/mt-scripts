base=`pwd`

for i in phrase_based/*-en; do
        pair=`echo $i | cut -d '/' -f2`;
        src=`echo $pair | cut -d '-' -f1`
        tgt=`echo $pair | cut -d '-' -f2`;
        cd $i/direct;
        echo "Testing pair $i";
        ~/tools/moses/bin/moses -threads 4 -f mert-work/moses.ini < ~/phrase-tables-LMs/corpora/$pair/test.$src > translated.$tgt;
	perl ~/tools/moses/scripts/generic/multi-bleu.perl ~/phrase-tables-LMs/corpora/$pair/test.$tgt < translated.$tgt > bleu-score;
        echo "Pair is $pair" >> ../all-bleu-score;
        cat bleu-score >> ../all-bleu-score;
	cd $base;

        for j in $i/moses-*.ini; do
                piv=`echo $j | cut -d '-' -f4`;
                cd $i/$piv;
                echo "For pivot $piv";
                ~/tools/moses/bin/moses -threads 4 -f mert-work/moses.ini < ~/phrase-tables-LMs/corpora/$pair/test.$src > translated.$tgt;
		perl ~/tools/moses/scripts/generic/multi-bleu.perl ~/phrase-tables-LMs/corpora/$pair/test.$tgt < translated.$tgt > bleu-score;
	        echo "Pivot is $piv" >> ../all-bleu-score;
        	cat bleu-score >> ../all-bleu-score;
		cd $base;
        done;
done

