#!/bin/bash
#read .log format ->  p,[C]v,[A]w,[T]x,[G]y,[N]z,t,.
# p-> position
# v,w,x,y,z -> the amount of each nucleotids
# t -> total
#get minority variants > 20 pct
for line in $(cat $1);
  do COV=$(echo $(echo $line) | rev | cut -d',' -f 2 | rev);
     line2=$( echo $line | cut -d"]" -f 2,3,4,5,6 --output-delimiter=",");
     line2=$( echo $line2 | rev | cut -d"," -f 3,4,5,6,7,8,9,10,11 | rev);
     line2=$(echo $line2 | sed s"/,\[T,/,/" | sed s"/,\[G,/,/" | sed s"/,\[A,/,/" | sed s"/,\[C,/,/" | sed s"/,\[N,/,/");
     score=0;
     for i in $(echo $line2 | sed s/,/\\t/g );
       do if [ $i -gt $(expr $COV / 20 ) ];
           then score=$(expr $score + 1 ) ;
          fi ;
           if [ $score -eq 2 ];
              then if [ $COV -gt 19 ];
                then echo $line ;score=3;
                   fi;
          fi;
       done;
  done;
