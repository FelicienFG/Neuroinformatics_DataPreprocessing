#!/bin/bash

S1obj='S1 obj'
S1S2_nomatch='S2 nomatch'
S1S2_match='S2 match'

function sort_trials ()
{
    subject_name=$1;
    #for every single stimulus trials (S1 stimulus)
    for file in $(grep -l "$S1obj" $subject_name/*) ; do
        filename="$(basename -- $file)";
        mv $file "S1obj/$subject_name/$filename"
    done;

    #for every two matched stimli trials (S1 and S2 are the same)
    for file in $(grep -l "$S1S2_match" $subject_name/*) ; do
        filename="$(basename -- $file)";
        mv $file "S1S2_match/$subject_name/$filename"
    done;

    #for every two no matched stimuli trials (S1 and S2 are different)
    for file in $(grep -l "$S1S2_nomatch" $subject_name/*) ; do
        filename="$(basename -- $file)";
        mv $file "S1S2_nomatch/$subject_name/$filename"
    done    

}


for dir_name in $(find . -maxdepth 1 -type d -name "co*") ; do
    mkdir S1obj/$dir_name;
    mkdir S1S2_match/$dir_name;
    mkdir S1S2_nomatch/$dir_name;
    sort_trials $dir_name &
done