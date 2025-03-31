#!/bin/bash

# Создание пользователя user-reader
echo "Создание пользователя user-reader..."
openssl genrsa -out user-reader.key 2048
openssl req -new -key user-reader.key -out user-reader.csr -subj "/CN=user-reader/O=group-viewer"
openssl x509 -req -in user-reader.csr -CA .minikube/ca.crt -CAkey .minikube/ca.key -CAcreateserial -out user-reader.crt -days 365
kubectl config set-credentials user-reader --client-certificate=user-reader.crt --client-key=user-reader.key
kubectl config set-context user-reader-context --cluster=minikube --user=user-reader

# Создание пользователя user-writer
echo "Создание пользователя user-writer..."
openssl genrsa -out user-writer.key 2048
openssl req -new -key user-writer.key -out user-writer.csr -subj "/CN=user-writer/O=group-editor"
openssl x509 -req -in user-writer.csr -CA .minikube/ca.crt -CAkey  .minikube/ca.key -CAcreateserial -out user-writer.crt -days 365
kubectl config set-credentials user-writer --client-certificate=user-writer.crt --client-key=user-writer.key
kubectl config set-context user-writer-context --cluster=minikube --user=user-writer