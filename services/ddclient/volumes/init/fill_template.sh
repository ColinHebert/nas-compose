#!/bin/bash
apk add --update gettext
envsubst < /config/ddclient.conf.tpl > /ddclient.conf
