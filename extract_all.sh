#!/bin/bash


for s1 in ./*.tar.gz ; do
	tar -xvf "$s1";
	rm "$s1";
	filename="${s1%.*}";
	filename="${filename%.*}";
	{ for s2 in $filename/*.gz ; do
		rawdata_filename="${s2%.*}";
		gunzip -c "$s2" > "$rawdata_filename";
		rm "$s2";
	done } &
done

