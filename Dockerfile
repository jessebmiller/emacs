from fedora
maintainer jesse@jessebmiller.com

run dnf update -y \
 && dnf install -y \
    emacs \
    gpg \
    java-1.?.0-openjdk-devel \
    tar \
    wget

# install lein (taken from https://github.com/Quantisan/docker-clojure/blob/0d4a0abe13497a6081ebd080e83d1be0abab3f59/Dockerfile)
env LEIN_VERSION=2.6.1
env LEIN_INSTALL=/usr/local/bin/

workdir /tmp

# Download the whole repo as an archive
run mkdir -p $LEIN_INSTALL \
 && wget --quiet https://github.com/technomancy/leiningen/archive/$LEIN_VERSION.tar.gz \
 && echo "Comparing archive checksum ..." \
 && echo "f7643a14fd8a4d5c19eeb416db8ea549d8d2c18a *$LEIN_VERSION.tar.gz" | sha1sum -c - \

 && mkdir ./leiningen \
 && tar -xzf $LEIN_VERSION.tar.gz  -C ./leiningen/ --strip-components=1 \
 && mv leiningen/bin/lein-pkg $LEIN_INSTALL/lein \
 && rm -rf $LEIN_VERSION.tar.gz ./leiningen \

 && chmod 0755 $LEIN_INSTALL/lein \

 # Download and verify Lein stand-alone jar
 && wget --quiet https://github.com/technomancy/leiningen/releases/download/$LEIN_VERSION/leiningen-$LEIN_VERSION-standalone.zip \
 && wget --quiet https://github.com/technomancy/leiningen/releases/download/$LEIN_VERSION/leiningen-$LEIN_VERSION-standalone.zip.asc \

 && gpg --keyserver pool.sks-keyservers.net --recv-key 2E708FB2FCECA07FF8184E275A92E04305696D78 \
 && echo "Verifying Jar file signature ..." \
 && gpg --verify leiningen-$LEIN_VERSION-standalone.zip.asc \

 # Put the jar where lein script expects
 && rm leiningen-$LEIN_VERSION-standalone.zip.asc \
 && mv leiningen-$LEIN_VERSION-standalone.zip /usr/share/java/leiningen-$LEIN_VERSION-standalone.jar

 # Some REPLs (e.g., Figwheel) necessitate a readline wrapper.
run dnf install -y readline-devel

# make a basic cider setup for lein
run mkdir -p /root/.lein/
run echo "{:user {:plugins [[cider/cider-nrepl \"0.8.2\"]]}}" > /root/.lein/profiles.clj

env LEIN_ROOT please

env PATH=$PATH:$LEIN_INSTALL

copy emacs.d /root/.emacs.d
