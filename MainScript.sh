#!/bin/bash

if [[ -z $6 ]];
then
        echo -e "Parameters missing,\nPlease make sure the command looks like : ./MainScript.sh -h \"https://rds-url.com\" -u \"db-username\" -p \"db-password\" -d \"db-name\" -s \"bucket-name\" -o \"dump-filename\" \nTry again."
        exit;
else
	# Parse input flags
	while getopts "h:u:p:d:s:o:" opt; do
	  case $opt in
		h) URL="$OPTARG" ;;
		u) USERNAME="$OPTARG" ;;
		p) PASSWORD="$OPTARG" ;;
		d) DATABASE="$OPTARG" ;;
		s) S3="$OPTARG" ;;
		o) OUT="$OPTARG" ;;
		\?) echo "Invalid option -$OPTARG" >&2; exit 1 ;;
		:) echo "Option -$OPTARG requires an argument" >&2; exit 1 ;;
	  esac
	done

	# Print input variables
	echo "URL: $URL"
	echo "Username: $USERNAME"
	echo "Password: $PASSWORD"
	echo "Database: $DATABASE"
	echo "S3: $S3"
	echo "Output: $OUT"

        echo "-----------------------\n"

	echo "Backup Initiated"

        echo "MySQL Dump Started"

        mysqldump -h $URL -u $USERNAME -p$PASSWORD $DATABASE --max_allowed_packet=1G > $OUT-$(date "+%d-%b-%Y").sql

        echo "Dump Completed, Compressing the dump file..."

        zip $OUT-$(date "+%d-%b-%Y").sql.zip -9 $OUT-$(date "+%d-%b-%Y").sql

        echo "Compression done, Copying the compressed file to AWS S3 bucket"

        aws s3 cp $OUT-$(date "+%d-%b-%Y").sql.zip s3://$S3

        echo "Copy process to AWS S3 bucket done!"

        rm $OUT-$(date "+%d-%b-%Y").*

        echo "Bakcup Finished, Thank you"

        echo "©dcgmechanics"

        exit

fi

