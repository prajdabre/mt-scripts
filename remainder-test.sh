base=`pwd`
i=phrase_based/ur-en
pair=ur-en
src=ur
tgt=en
        cd $i/direct;
        echo "Testing pair $i";
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

