# Start all services
$GRIDINITCMD -S $GRIDINIT_SOCKET start

echo "Waiting for the 3 meta1 to register ..."
etime_start=$(date +"%s")
etime_end=$(($etime_start + $TIMEOUT))
nbmeta1=0
while [ $(date +"%s") -le $etime_end -a $nbmeta1 -lt $NBREPLICAS ]
do
  sleep $WAIT
  # Count registered meta1
  nbmeta1=$($OIOCLUSTER -r $NS | grep -c meta1)
done
if [ $nbmeta1 -ne $NBREPLICAS ]; then
  echo "Error: Install script did not found $NBREPLICAS meta1 services registered. Return: $nbmeta1"
  exit 1
fi

# Initialize meta1 with 3 replicas on the same server
echo "Loading meta0 ..."
$OIOMETA0INIT -O NbReplicas=$NBREPLICAS -O IgnoreDistance=$IGNOREDISTANCE $NS || \
  (echo "Error: $OIOMETA0INIT failed. Aborting." ; exit 1)

# Restarting meta0 and meta1
echo "Restarting directory services ..."
$GRIDINITCMD -S $GRIDINIT_SOCKET restart @meta0
$GRIDINITCMD -S $GRIDINIT_SOCKET restart @meta1
$GRIDINITCMD -S $GRIDINIT_SOCKET restart @meta2

# Waiting for service to restart ...
sleep 5

