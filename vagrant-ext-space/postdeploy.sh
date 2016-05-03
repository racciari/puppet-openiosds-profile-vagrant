# Start all services
$GRIDINITCMD -S $GRIDINIT_SOCKET start

sleep $WAIT

# Unlock services scores
$OIOCLUSTER -r $NS | xargs -n1 $OIOCLUSTER --unlock-score -S
