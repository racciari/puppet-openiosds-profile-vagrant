NBREPLICAS=3

# Start all services
$GRIDINITCMD -S $GRIDINIT_SOCKET start

echo "> Waiting for the meta1 to register ..."
etime_start=$(date +"%s")
etime_end=$(($etime_start + $TIMEOUT))
nbmeta1=0
while [ $(date +"%s") -le $etime_end -a $nbmeta1 -lt $NBREPLICAS ]
do
  sleep $WAIT
  # Count registered meta1
  nbmeta1=$(/usr/bin/openio --oio-ns=$NS cluster list meta1 -f value -c Id|wc -l)
done
if [ $nbmeta1 -ne 1 ]; then
  echo "Error: Install script did not found 1 meta1 service registered after $TIMEOUT. $nbmeta1 meta1 found."
  exit 1
fi

echo "> Unlocking scores ..."
etime_start=$(date +"%s")
etime_end=$(($etime_start + $TIMEOUT))
nbscore=$NBREPLICAS
while [ $(date +"%s") -le $etime_end -a $nbscore -gt 0 ]
do
  /usr/bin/openio --oio-ns=$NS cluster unlockall >/dev/null 2>&1
  sleep 2
  nbscore=$(/usr/bin/openio --oio-ns=$NS cluster list meta1 -f value -c Score|grep -c -e '^0$' || echo 4)
done
if [ $nbscore -gt 0 ]; then
  echo "Error: Unlocking scores failed. Unable to bootstrap namespace. Return: Number of failed score = $score"
  exit 1
fi

# Initialize meta1 with 3 replicas on the same server
echo "> Bootstrapping directory ..."
/usr/bin/openio --oio-ns=$NS directory bootstrap --replicas $NBREPLICAS || \
  (echo "Error: Directory bootstrap failed. Aborting." ; exit 1)

# Restarting meta0 and meta1
echo "> Restarting directory services ..."
$GRIDINITCMD restart @meta0 @meta1 @meta2

sleep 5

