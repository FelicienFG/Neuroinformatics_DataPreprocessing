#!/bin/bash

experiments_dirs="S1obj S1S2_match S1S2_nomatch"

function merge()
{
mother_filename=$1;
directory=$2;
alcoholic=$3;
group='c';
stimulus=0;

if [ "$alcoholic" == "alcoholic" ] ; then
    group='a'
fi

if [ "$directory" == "S1S2_match" ] ; then
    stimulus=1
elif [ "$directory" == "S1S2_nomatch" ] ; then
    stimulus=2
fi

touch $directory/$alcoholic/$mother_filename;
mother_file="$directory/$alcoholic/$mother_filename"
i=0
for file in $directory/$alcoholic/co* ; do
    if [ $i -ne 0 ] ; then
        
        echo "$(tail -n +2 $file)" >> $mother_file
    else
        cp $file $mother_file
    fi;
    i=1;
done;


echo "$(awk -v stm="$stimulus " 'BEGIN {OFS=" "} NR==1 {$1 = "stimulus " $1} NR>1 {$1 = stm $1} 1' $mother_file)" > $mother_file;
echo "$(awk -v grp="$group " 'BEGIN {OFS=" "} NR==1 {$1 = "group " $1} NR>1 {$1 = grp $1} 1' $mother_file)" > $mother_file;

}

for dir in $experiments_dirs ; do
    merge "big_file" $dir "alcoholic";
    merge "big_file" $dir "control";
done


