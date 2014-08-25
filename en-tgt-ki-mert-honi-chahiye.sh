base=`pwd`

for i in phrase_based/*-en; do
        pair=`echo $i | cut -d '/' -f2`;
        src=`echo $pair | cut -d '-' -f1`
        tgt=`echo $pair | cut -d '-' -f2`;
        mkdir $i/direct;
        cd $i/direct;
        echo "Doing mert on pair $i";
        ~/tools/moses/scripts/training/mert-moses.pl ~/phrase-tables-LMs/corpora/$pair/tun.$src ~/phrase-tables-LMs/corpora/$pair/tun.$tgt ~/tools/moses/bin/moses ../moses.ini --mertdir ~/tools/moses/bin/ --rootdir ~/tools/moses/scripts/ -no-filter-phrase-table --batch-mira --return-best-dev --batch-mira-args '-J 100' --decoder-flags '-threads 4 -v 0';
        cd $base;

        for j in $i/moses-*.ini; do
                piv=`echo $j | cut -d '-' -f4`;
                mkdir $i/$piv;
                cd $i/$piv;
                echo "For pivot $piv";
                ~/tools/moses/scripts/training/mert-moses.pl ~/phrase-tables-LMs/corpora/$pair/tun.$src ~/phrase-tables-LMs/corpora/$pair/tun.$tgt ~/tools/moses/bin/moses ../moses-$src-$piv-$tgt.ini --mertdir ~/tools/moses/bin/ --rootdir ~/tools/moses/scripts/ -no-filter-phrase-table --batch-mira --return-best-dev --batch-mira-args '-J 100' --decoder-flags '-threads 4 -v 0';
                cd $base;
        done;
done

