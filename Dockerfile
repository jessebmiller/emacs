from alpine
maintainer jesse@jessebmiller.com

run echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk update \
 && apk add --update --no-cache emacs@testing

entrypoint emacs