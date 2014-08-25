base=`pwd`

for i in phrase_based/en-*; do
        pair=`echo $i | cut -d '/' -f2`;
        src=`echo $pair | cut -d '-' -f1`
        tgt=`echo $pair | cut -d '-' -f2`;
	echo "For pair $pair" >> significance-all;
        for j in $i/moses-direct-plus-*.ini; do
                piv=`echo $j | cut -d '-' -f5 | cut -d '.' -f1 `;
                echo "For pivot $piv" >> significance-all;
                 ~/tools/moses/scripts/analysis/bootstrap-hypothesis-difference-significance.pl $i/direct/translated.$tgt $i/direct-plus-$piv/translated.$tgt ~/phrase-tables-LMs/corpora/$pair/test.$tgt >>significance-all;
		cd $base;
        done;
done

base=`pwd`

for i in phrase_based/*-en; do
        pair=`echo $i | cut -d '/' -f2`;
        src=`echo $pair | cut -d '-' -f1`
        tgt=`echo $pair | cut -d '-' -f2`;
        echo "For pair $pair" >> significance-all;
        for j in $i/moses-direct-plus-*.ini; do
                piv=`echo $j | cut -d '-' -f5 | cut -d '.' -f1 `;
                echo "For pivot $piv" >> significance-all;
                 ~/tools/moses/scripts/analysis/bootstrap-hypothesis-difference-significance.pl $i/direct/translated.$tgt $i/direct-plus-$piv/translated.$tgt ~/phrase-tables-LMs/corpora/$pair/test.$tgt >>significance-all;
                cd $base;
        done;
done


