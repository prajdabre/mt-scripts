cd phrase_based

for i in *; do 
	echo "In $i"; 
	for j in $i/phrase-table*.gz; do 
		echo "Processing $j"; /home/raj/tools/moses/bin/processPhraseTable    -ttable 0 0 $j -nscores 5 -out `echo $j | cut -d '.' -f1`; 
	done; 
	echo "Processing reordering table for $i"; /home/raj/tools/moses/bin/processLexicalTable -in $i/reordering-table.wbe-msd-bidirectional-fe.gz -out $i/reordering-table; 
done

cd ..
