if [ "$(ls -A /home/me)" ]; then
	# not empty
	rdiff-backup --exclude-globbing-filelist ~/.nixconfig/backupscripts/homedir.includeexclude ~ /mnt/big/backup/homedir
else
	# not mounted -> do nothing
	echo 'not backuping homedir'
fi
