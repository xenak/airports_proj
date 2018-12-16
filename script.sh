rm ~/info.csv
printf 'Airport\tWind (MPH)\tTemperature (C)\tStatus\n' > ~/info.csv


for airports in $(cat ~/airports.txt); do
   curl http://tgftp.nws.noaa.gov/data/observations/metar/decoded/$airports.TXT > ~/text.txt;
   if grep -q  "MPH" ~/text.txt; then
      grep "Wind:" ~/text.txt > ~/wind.txt
      if grep -q "to" ~/wind.txt; then
         WIND=$(grep -oP "to\s+\K\w+" ~/wind.txt);
      else
          WIND=$(grep -oP "at\s+\K\w+" ~/wind.txt);
      fi 
   else 
      WIND=$(echo "0");
   fi
   TEMP=$(grep "Temperature" ~/text.txt  | awk '{print $4}'  | cut -c 2-);
   if [ ${TEMP%.*} -gt "-3"  ]; then
      if [ $WIND -gt 15 ]; then
         MESS=$(echo "Be careful!");
      else
         MESS=$(echo "Everything is fine!");
      fi
   else
      MESS=$(echo "Be careful!");
   fi
   printf "$airports\t$WIND\t$TEMP\t$MESS\n" >> ~/info.csv
done < ~/airports.txt

rm ~/wind.txt
rm ~/text.txt
