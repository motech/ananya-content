#!/bin/bash
for file in `ls -1 *out_of*`
do
	git mv $file chapter1_${file} 
done
