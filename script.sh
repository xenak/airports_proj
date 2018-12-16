rm ~/homework/info.csv
printf 'Airport\tWind (MPH)\tTemperature (C)\tStatus\n' > ~/homework/info.csv


for airports in $(cat ~/homework/airports.txt); do
   curl http://tgftp.nws.noaa.gov/data/observations/metar/decoded/$airports.TXT > ~/homework/text.txt;
   if grep -q  "MPH" ~/homework/text.txt; then
      grep "Wind:" ~/homework/text.txt > ~/homework/wind.txt
      if grep -q "to" ~/homework/wind.txt; then
         WIND=$(grep -oP "to\s+\K\w+" ~/homework/wind.txt);
      else
          WIND=$(grep -oP "at\s+\K\w+" ~/homework/wind.txt);
      fi 
   else 
      WIND=$(echo "0");
   fi
   TEMP=$(grep "Temperature" ~/homework/text.txt  | awk '{print $4}'  | cut -c 2-);
   if [ ${TEMP%.*} -gt "-3"  ]; then
      if [ $WIND -gt 15 ]; then
         MESS=$(echo "Be careful!");
      else
         MESS=$(echo "Everything is fine!");
      fi
   else
      MESS=$(echo "Be careful!");
   fi
   printf "$airports\t$WIND\t$TEMP\t$MESS\n" >> ~/homework/info.csv
done < ~/homework/airports.txt

rm ~/homework/wind.txt
rm ~/homework/text.txt
