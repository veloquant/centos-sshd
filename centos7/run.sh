#!/bin/bash

if [ "${AUTHORIZED_KEYS}" != "**None**" ]; then
    echo "=> Found authorized keys"
    mkdir -p /root/.ssh
    chmod 700 /root/.ssh
    touch /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    IFS=$'\n'
    arr=$(echo ${AUTHORIZED_KEYS} | tr "," "\n")
    for x in $arr
    do
        x=$(echo $x |sed -e 's/^ *//' -e 's/ *$//')
        cat /root/.ssh/authorized_keys | grep "$x" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "=> Adding public key to /root/.ssh/authorized_keys: $x"
            echo "$x" >> /root/.ssh/authorized_keys
        fi
    done
fi

if [ ! -f /.root_pw_set ]; then
	/set_root_pw.sh
fi

# TODO: Allow the launching of systemd to be suppressed using an environment variable.
# Attempt to launch systemd if possible
[ -r /sys/fs/cgroup ] && [ -d /sys/fs/cgroup ] && [ -d /run/dbus/ ] && exec /usr/sbin/init

echo "NOTICE: Preconditions for running systemd not satisfied, running sshd directly"
exec /usr/sbin/sshd -D
