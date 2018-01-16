#!/bin/bash

PATHNAME=/u/eot/reames/temp
COUNTER=0

files=(/u/eot/reames/temp/tmp*.sh)
i=0
while [ $i -le 1392 ] ; do

temp_file=$(mktemp --tmpdir=/u/eot/reames/temp --suffix=".bsub")
    chmod 754 $temp_file

    cat <<EOM >$temp_file

##!/bin/bash

#PBS -q low
#PBS -l nodes=1:ppn=20:xe
#PBS -l walltime=01:30:00
#PBS -N ADD.VARS.$COUNTER
#PBS -e /u/eot/reames/temp/runncl.$COUNTER.err
#PBS -o /u/eot/reames/temp/runncl.$COUNTER.out
##PBS -m bea
#PBS -M lreames@ou.edu
cd $PATHNAME
echo $COUNTER
EOM
let fin=$i+11
let j=$i
while [ $j -le $fin ]; do
file=${files[$j]}

cat <<EOM >>$temp_file
aprun -n 1 -d 20 $file

#
EOM
let j=$j+1
done
##:trap "rm -f $i" 0 2 3 15 
qsub < $temp_file
let COUNTER=$COUNTER+1
let i=$i+12
done
