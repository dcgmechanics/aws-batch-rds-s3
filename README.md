# aws-batch-rds-s3

Automate RDS Dump To S3 With The Docker Image And AWS Batch.
Docker Image: https://hub.docker.com/r/dcgmechanics/rds-s3

Script: docker run -exec dcgmechanics/rds-s3 ./MainScript.sh -h "https://rds-url.com" -u "db-username" -p "db-password" -d "db-name" -s "s3-bucket-name" -o "op-dump-name"

#Thank You
