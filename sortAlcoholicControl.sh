#!/bin/bash

experiments_dirs="./S1obj ./S1S2_match ./S1S2_nomatch"

for dir in $experiments_dirs ; do
    mkdir $dir/alcoholic;
    mkdir $dir/control;
    for alcohol_txt_file in $(find $dir -maxdepth 1 -type f -regextype posix-extended -regex ".+co[23]a.+\.txt") ; do
        mv $alcohol_txt_file $dir/alcoholic/
    done;
    for control_txt_file in $(find $dir -maxdepth 1 -type f -regextype posix-extended -regex ".+co[23]c.+\.txt") ; do
        mv $control_txt_file $dir/control/
    done
done