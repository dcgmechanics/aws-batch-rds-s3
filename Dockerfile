FROM ubuntu:latest

RUN apt update && apt upgrade -y

RUN apt install curl zip mysql-client -y

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install && rm awscliv2.zip

COPY ./MainScript.sh .

RUN chmod +x MainScript.sh

CMD ./MainScript.sh
