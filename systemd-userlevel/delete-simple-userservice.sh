#!/bin/bash
#
# deletes user-level systemd service
#

service=simple

echo "stopping service $service"

systemctl --user stop $service.timer
systemctl --user stop $service.service
systemctl --user disable $service.service $service.timer
echo "stopped and disabled user-level systemd services: $service"

rm ~/.config/systemd/user/$service.service
rm ~/.config/systemd/user/$service.timer
echo "deleted files for user-level $service in ~/.config/systemd/user"

systemctl --user daemon-reload
echo "restarted systemd daemon"

echo "==========================="
echo "list of $service user-level services still available..."
systemctl --user --no-pager | grep $service

echo "==========================="
echo "list of timers for $service user-level timers still available..."
systemctl --user list-timers --no-pager | grep $service
