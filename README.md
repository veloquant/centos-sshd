centos-sshd
===========

Simple CentOS docker image with SSH access

Note: This project is a fork of [tutum/centos](https://github.com/tutumcloud/tutum-centos).=
That project has been deprecated by its publishers and is no longer maintained.

Currently, its scope is more limited. Only CentOS 7 is tested and known to work.
However, the code for building the latest CentOS has been retained.


Availability
------------

A Docker image for CentOS 7 built from this repository [is available
on Docker hub](https://hub.docker.com/repository/docker/yitzikc/centos-sshd), as _yitzikc/centos-sshd:centos7_

You can adapt the examples below to use it directly, by using the image name
_yitzikc/centos-sshd:centos7_ instead of _centos-sshd:centos7_.

Usage
-----

To create the image `centos-sshd` with one tag per CentOS release, execute the following commands on the repository folder:

	docker build -t centos:centos7 centos7

The code for building the latest release of CentOS (currently 8) has been retained,
but is it likely to encounter errors. To run it:

	docker build -t centos:latest .


Running centos-sshd
--------------------

Run a container from the image you created earlier binding it to port 2222 in all interfaces:

	docker run -d -p 0.0.0.0:2222:22 centos-sshd:centos7

The first time that you run your container, a random password will be generated
for user `root`. To get the password, check the logs of the container by running:

	docker logs <CONTAINER_ID>

You will see an output like the following:

	========================================================================
	You can now connect to this CentOS container via SSH using:

	    ssh -p <port> root@<host>
	and enter the root password 'U0iSGVUCr7W3' when prompted

	Please remember to change the above password as soon as possible!
	========================================================================

In this case, `U0iSGVUCr7W3` is the password allocated to the `root` user.

Done!


Setting a specific password for the root account
------------------------------------------------

If you want to use a preset password instead of a random generated one, you can
set the environment variable `ROOT_PASS` to your specific password when running the container:

	docker run -d -p 0.0.0.0:2222:22 -e ROOT_PASS="mypass" centos-sshd:centos7


Adding SSH authorized keys
--------------------------

If you want to use your SSH key to login, you can use the `AUTHORIZED_KEYS` environment variable. You can add more than one public key separating them by `,`:

    docker run -d -p 2222:22 -e AUTHORIZED_KEYS="`cat ~/.ssh/id_rsa.pub`" centos-sshd:centos7
