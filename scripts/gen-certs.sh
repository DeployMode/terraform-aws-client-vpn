#!/usr/bin/env bash

# Based on https://github.com/achuchulev/terraform-aws-client-vpn-endpoint/blob/master/scripts/gen_acm_cert.sh

STORAGE_DIR=$1
DOMAIN=$2
STAGE=$3

git clone https://github.com/OpenVPN/easy-rsa.git
pushd easy-rsa/easyrsa3
./easyrsa init-pki
export EASYRSA_BATCH=1
./easyrsa build-ca nopass
./easyrsa build-server-full server nopass
./easyrsa build-client-full $STAGE.$DOMAIN nopass
mkdir -p ../../$STORAGE_DIR
mv pki/ca.crt ../../$STORAGE_DIR/
mv pki/issued/server.crt ../../$STORAGE_DIR/
mv pki/private/server.key ../../$STORAGE_DIR/
mv pki/issued/$STAGE.$DOMAIN.crt ../../$STORAGE_DIR/
mv pki/private/$STAGE.$DOMAIN.key ../../$STORAGE_DIR/
popd
rm -rf ./easy-rsa
unset EASYRSA_BATCH