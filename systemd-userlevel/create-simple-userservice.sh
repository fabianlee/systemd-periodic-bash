#!/bin/bash
#
# creates user-level systemd service that runs simple bash script
#

user=$(id -un)
service=simple

echo $XDG_RUNTIME_DIR
echo $DBUS_SESSION_BUS_ADDRESS

systemctl --user status >/dev/null 2>&1
[ $? -eq 0 ] || { echo "ERROR running systemctl as non-root user.  Need 'systemctl --user status' to run correctly before running this script."; exit 1; }

userdir=$(realpath ~)
echo "user home dir: $userdir"

# path to bash script that will be executed
scriptdir=$(realpath ..)
[ -f "$scriptdir/simple-bash.sh" ] || { echo "ERROR did not find script: $scriptdir/simple-bash.sh"; exit 3; }

# make directory for use-level systemd service
mkdir -p ~/.config/systemd/user/

# create user level systemd service file
sed "s#\$scriptdir#${scriptdir}#g; s#\$userdir#${userdir}#g" $service.service | tee ~/.config/systemd/user/$service.service >/dev/null
chmod 655 ~/.config/systemd/user/$simple.service
echo "created systemd service file: ~/.config/systemd/user/$service.service"

# create custom systemd timer file
cp $service.timer ~/.config/systemd/user/.
chmod 655 ~/.config/systemd/user/$service.timer

echo "reloading systemctl..."
systemctl --user daemon-reload

echo "making log directory at $userdir/log/$service"
mkdir -p $userdir/log/$service
chmod -R 755 $userdir/log

# create custom environment configuration
if [ ! -f ~/default/$service ]; then
  mkdir -p ~/default
  echo "env_var=" | tee ~/default/$service
fi
chmod 600 ~/default/$service

echo "starting service $service"
systemctl --user enable $service.service $service.timer
systemctl --user start $service.service
systemctl --user start $service.timer

echo "==========================="
echo "list of $service services available..."
systemctl --user --no-pager | grep $service

echo "==========================="
echo "list of timers for $service available..."
systemctl --user list-timers --no-pager | grep $service

echo ""
echo "==========================="
echo "logs for service $service"
journalctl --user -u $service.service --no-pager | tail -n10
