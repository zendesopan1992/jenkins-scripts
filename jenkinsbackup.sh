#!/bin/sh    

     ###
     # Easy Jenkins backup script
     #
     # Save script and named JenkinsFullBackup.sh
     # chmod +x JenkinsFullBackup.sh
     #
      
     # Which path of your jenkins install
     JENKINS_HOME=/var/lib/jenkins
      
     # Whcih path of your backup file saved 
     JENKINS_BACKUP_HOME=/home/ubuntu/backup/jenkins
      
     # Jenkins backup file ex: jenkins-backup.2014-10-05.tar.gz
     JENKINS_BACKUP_FILE=jenkins-backup.$(date +"%Y-%m-%d").tar.gz
      
     cd $JENKINS_HOME
      
     # backup workspace need lot of diskspace, you can ignore like
     # --exclude=./workspace
     tar zcvf $JENKINS_BACKUP_HOME/$JENKINS_BACKUP_FILE ./* \
     --exclude=./war

s3cmd put -r /home/ubuntu/backup/jenkins/jenkins-backup* s3://actv8-jenkinsconfig-backup && sudo rm -r -f /home/ubuntu/backup/jenkins/jenkins-backup*
