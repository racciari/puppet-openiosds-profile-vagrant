# Start all services
$GRIDINITCMD -S $GRIDINIT_SOCKET start

echo "> Waiting for the meta1 to register ..."
etime_start=$(date +"%s")
etime_end=$(($etime_start + $TIMEOUT))
nbmeta1=0
while [ $(date +"%s") -le $etime_end -a $nbmeta1 -lt 1 ]
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
score=0
while [ $(date +"%s") -le $etime_end -a $score -eq 0 ]
do
  /usr/bin/openio --oio-ns=$NS cluster unlockall >/dev/null 2>&1
  sleep 2
  score=$(/usr/bin/openio --oio-ns=$NS cluster list meta1 -f value -c Score || echo 0)
done
if [ $score -eq 0 ]; then
  echo "Error: Unlocking scores failed. Unable to bootstrap namespace. Return: Meta1 score = $score"
  exit 1
fi

# Initialize meta1 with 3 replicas on the same server
echo "> Bootstrapping directory ..."
/usr/bin/openio --oio-ns=$NS directory bootstrap --replicas $NBREPLICAS || \
  (echo "Error: Directory bootstrap failed. Aborting." ; exit 1)

# Restarting meta0 and meta1
echo "> Restarting directory services ..."
$GRIDINITCMD restart @meta0 @meta1

# Install swift client
/usr/bin/yum -yq install python-swiftclient
