cd /u/eot/reames/project/MAY31/

PATHNAME=/u/eot/reames/scratch/MAY31.DFW_moved/OUT

FILENUM=0
for i in $PATHNAME/x*00.nc; do

FILE='"'
FILE+=$i
FILE+='"'

makedir=$PATHNAME
makedir+='/data_file'
makedir+=$FILENUM
makedir+='/'

mkdir -p $makedir;
##  dotimes=1
echo $FILE
savedir='"'
savedir+=$makedir
savedir+='"'
##echo $savedir


for COUNTER in 0 20 40 60 80 100 120 140 160 180 200 220 240; do
    temp_file=$(mktemp --tmpdir=/u/eot/reames/temp --suffix=".sh")
    chmod 754 $temp_file

    cat <<EOM >$temp_file
#!/bin/bash
#
EOM
    let END=$COUNTER+25
    while [  $COUNTER -lt $END ]; do

         cat <<EOM >>$temp_file
ncl 'files=$FILE' 'get_time=$COUNTER' 'savedir=$savedir' /u/eot/reames/project/MAY31.FS/add.dbz.uhi.ncl &
EOM
    let COUNTER=$COUNTER+1
    done

    cat <<EOM >>$temp_file
#
wait
#
EOM

    #trap "rm -f $temp_file" 0 2 3 15

    #aprun -n 1 -d 25 $temp_file
done
let FILENUM=$FILENUM+1

done
