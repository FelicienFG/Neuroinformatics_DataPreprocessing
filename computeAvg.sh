#!/bin/bash

electrode_list="FP1 FP2 F7 F8 AF1 AF2 FZ F4 F3 FC6 FC5 FC2 FC1 T8 T7 CZ C3 C4 CP5 CP6 CP1 CP2 P3 P4 PZ P8 P7 PO2 PO1 O2 O1 X AF7 AF8 F5 F6 FT7 FT8 FPZ FC4 FC3 C6 C5 F2 F1 TP8 TP7 AFZ CP3 CP4 P5 P6 C1 C2 PO7 PO8 FCZ POZ OZ P2 P1 CPZ nd Y"
time_points=256
experiments_dirs="./S1obj ./S1S2_match ./S1S2_nomatch"

function subject_fileShrinking ()
{

    subject_dirname=$1
    subject_name=$(basename -- $subject_dirname)
    new_filename="${subject_name}.txt";
    echo $electrode_list > "${subject_dirname}/${new_filename}";
    for file in $(find $subject_dirname -type f -name "*.rd.*") ; do
        volt_average_string=""
        for channel in $electrode_list ; do
            volt_column=$(grep $channel $file | tail -n $time_points | awk '{print $NF}');
            volt_average=$(./compute_average.py "$volt_column");
            volt_average_string+="$volt_average ";
        done;
        echo $volt_average_string >> "${subject_dirname}/${new_filename}"
    done

}

for exp_dir in $experiments_dirs ; do
    for dir in $(find $exp_dir -type d -name "co*") ; do
        subject_fileShrinking $dir &
    done
done