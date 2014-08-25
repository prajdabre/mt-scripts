
for i in phrase_based/en-*; do
	cp $i/moses-comboall.ini $i/moses-comboall-modparams.ini;
	grep "PhraseDictionaryBinary" $i/moses-comboall.ini > temp;
	
	while read line; do 
		piv=`echo $line | cut -d ' ' -f5 | cut -d '-' -f7`;
		index=`echo $line | cut -d ' ' -f2 | cut -d '=' -f2`;
		params=`echo $index=$(grep "^TranslationModel0=" $i/$piv/mert-work/moses.ini| cut -d "=" -f2)`;
		sed -i "s@^$index.*@$params@g" $i/moses-comboall-modparams.ini;
	done < temp;
done

for i in phrase_based/*-en; do
        cp $i/moses-comboall.ini $i/moses-comboall-modparams.ini;
        grep "PhraseDictionaryBinary" $i/moses-comboall.ini > temp;

        while read line; do
                piv=`echo $line | cut -d ' ' -f5 | cut -d '-' -f7`;
                index=`echo $line | cut -d ' ' -f2 | cut -d '=' -f2`;
                params=`echo $index=$(grep "^TranslationModel0=" $i/$piv/mert-work/moses.ini| cut -d "=" -f2)`;
                sed -i "s@^$index.*@$params@g" $i/moses-comboall-modparams.ini;
        done < temp;
done

