if [ "$(ls /run/media/me | grep CEBA)" ]; then
	if [ "$(ls -A /run/media/me/4997-CEBA/)" ]; then
		# not empty
		rdiff-backup /run/media/me/4997-CEBA /mnt/big/backup/ceba
	else
		# not mounted -> do nothing
		echo 'not backuping ceba, ceba empty'
	fi
else
	echo 'not backuping ceba, ceba not mounted'
fi
