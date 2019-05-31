#!/bin/bash

# Script to backup git repo to S3
# Set bucket, dir, password and account to use for the backup.  I keep mine in local env vars 
# These are set by localrc which lives on an encrypted home directory and is executed by my bashrc
bucket=$actv8-github-repositories-backup
dir=$ACTV8meInc
password=$Sonpari@123
account=$zendesopan1992

# Setup repository to $1
repository=$1

date=`date '+%Y%m%d%H%M%S'`

# Create the backup directory
mkdir -p $dir

echo "Backing up $repository"

git clone --mirror git@github.com:$account/$repository.git $dir/$repository.$date.git
if [ $? -ne 0 ]; then
  echo "Error cloning $repository"
  exit 1
fi

tar cpzf $dir/$repository.$date.git.tar.gz $dir/$repository.$date.git
if [ $? -ne 0 ]; then
  echo "Error compressing $repository"
  exit 1
fi

#Optional file encryption
#echo $password | gpg -c --passphrase-fd 0 $dir/$repository.$date.git.tar.gz
#if [ $? -ne 0 ]; then
#  echo "Error encrypting $repository"
#  exit 1
#fi

if [ -f $dir/$repository.$date.git.tar.gz ]; then
  s3cmd put $dir/$repository.$date.git.tar.gz s3://$bucket/git.$repository.$date.git.tar.gz
fi

if [ $? -ne 0 ]; then
  echo "Error uploading $repository to S3"
  exit 1
fi

#delete tar file and checked out folder
/bin/rm $dir/$repository.$date.git.tar.gz
/bin/rm -rf $dir/$repository.$date.git
if [ $? -ne 0 ]; then
  echo "Error removing $repository"
  exit 1
fi

echo "Succesfully backed up $repository"

