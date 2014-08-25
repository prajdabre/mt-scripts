base=`pwd`

        mkdir phrase_based/gu-en/comboall;
        cd phrase_based/gu-en/comboall;
        echo "Doing mert on pair gu-en";
        ~/tools/moses/scripts/training/mert-moses.pl ~/phrase-tables-LMs/corpora/gu-en/tun.gu ~/phrase-tables-LMs/corpora/gu-en/tun.en ~/tools/moses/bin/moses ../moses-comboall.ini --mertdir ~/tools/moses/bin/ --rootdir ~/tools/moses/scripts/ -no-filter-phrase-table --batch-mira --return-best-dev --batch-mira-args '-J 100' --continue --decoder-flags '-threads 4 -v 0';
        echo "Testing pair gu-en";
        ~/tools/moses/bin/moses -threads 4 -f mert-work/moses.ini < ~/phrase-tables-LMs/corpora/gu-en/test.gu > translated.en;
        perl ~/tools/moses/scripts/generic/multi-bleu.perl ~/phrase-tables-LMs/corpora/gu-en/test.en < translated.en > bleu-score;
        echo "When all is combined for pair: gu-en" >> ../combo-bleu-score;
        cat bleu-score >> ../combo-bleu-score;


