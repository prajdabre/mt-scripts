
for i in phrase_based/en-*; do
	grep "PhraseDictionaryBinary" $i/moses-comboall.ini > temp;
	
	while read line; do 
		piv=`echo $line | cut -d ' ' -f5 | cut -d '-' -f7`;
		cp $i/direct/mert-work/moses.ini $i/moses-direct-plus-$piv.ini;
		ptpath=`grep "PhraseDictionaryBinary" $i/$piv/mert-work/moses.ini |  sed "s@TranslationModel0@TranslationModel1@g"`;	
		params=`echo TranslationModel1=$(grep "^TranslationModel0=" $i/$piv/mert-work/moses.ini| cut -d "=" -f2)`;
		sed -i "s@^TranslationModel0.*@&\n$params@g" $i/moses-direct-plus-$piv.ini;
		sed -i "s@^0 T 0\$@&\n1 T 1@g" $i/moses-direct-plus-$piv.ini;
		sed -i "s@^PhraseDictionaryBinary.*@&\n$ptpath@g" $i/moses-direct-plus-$piv.ini;
	done < temp;
done

for i in phrase_based/*-en; do
        grep "PhraseDictionaryBinary" $i/moses-comboall.ini > temp;

        while read line; do
                piv=`echo $line | cut -d ' ' -f5 | cut -d '-' -f7`;
                cp $i/direct/mert-work/moses.ini $i/moses-direct-plus-$piv.ini;
                ptpath=`grep "PhraseDictionaryBinary" $i/$piv/mert-work/moses.ini |  sed "s@TranslationModel0@TranslationModel1@g"`;
                params=`echo TranslationModel1=$(grep "^TranslationModel0=" $i/$piv/mert-work/moses.ini| cut -d "=" -f2)`;
                sed -i "s@^TranslationModel0.*@&\n$params@g" $i/moses-direct-plus-$piv.ini;
		sed -i "s@^0 T 0\$@&\n1 T 1@g" $i/moses-direct-plus-$piv.ini;
                sed -i "s@^PhraseDictionaryBinary.*@&\n$ptpath@g" $i/moses-direct-plus-$piv.ini;
        done < temp;
done


