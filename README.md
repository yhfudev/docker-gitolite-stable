# WHAT IT IS

A Dockerfile for a container for sshd with gitolite.

# WHAT IT ISN'T

An image on the docker registry. When you set up gitolite you have to
provide a public ssh key for the first admin user. This repo has mine,
replace it with yours before building.

# INSTRUCTIONS

1. Replace adminkey.pub with your own public ssh key (it's probably at
   ``$HOME/.ssh/id_rsa.pub``).

2. Build the image:

    > $ docker build -rm -t gitolite .

3. Pick a port number (PORT) to run it publicly on, and run the
   container:

    > $ docker run -d -p PORT:22 gitolite

4. On your own machine (with the container running on HOST), clone the
   gitosis-admin repo:

    > $ git clone ssh://git@HOST:PORT/gitolite-admin

5. To fetch the default gitolite-admin repo, first run the image by bash
   command:

    > $ docker run -i -v /home/data/git:/test -t yhfu/gitolite /bin/bash

    and then copy the gitolite-admin to the mounted dir /test in docker
    image:

    > $ cp -rp /home/git/repositories/* /test/
