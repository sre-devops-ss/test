FROM node:16.13.2
WORKDIR /codeartifact.dev.bestdocapp.in
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
RUN unzip awscliv2.zip
RUN ./aws/install -i /usr/local/aws-cli -b /usr/local/bin

ARG ACCESS_KEY_ID
ARG SECRET_ACCESS_KEY
ARG AWS_REGION

ENV ACCESS_KEY_ID=$ACCESS_KEY_ID
ENV SECRET_ACCESS_KEY=$SECRET_ACCESS_KEY
ENV AWS_REGION=$AWS_REGION

COPY . .
RUN aws configure set aws_access_key_id "AKIAZFFYKAOLNX2AMYUD"
RUN aws configure set aws_secret_access_key "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" 
RUN aws configure set region "ap-south-1"
RUN aws configure set output "json"
RUN aws codeartifact get-authorization-token --domain healthcare-plugin --domain-owner 629599241110 --query authorizationToken --output text --region ap-south-1
RUN aws codeartifact login --tool npm --repository home-care --domain healthcare-plugin --domain-owner 629599241110
RUN npm install
