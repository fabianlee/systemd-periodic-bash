# systemd-periodic-bash

Example of running bash script periodically using systemd (either system level or user level).


## for testing one-time run
    env_arg=foo ./simple-bash.sh 2
    
## for periodic run with user-level systemd service
    cd systemd-userlevel
    ./simple-bash.sh 2
    vi ~/default/simple
    
    tail -f ~/log/simple/*
    
    
## for periodic run with system-level systemd service
    cd systemd-systemlevel
    ./simple-bash.sh 2
    vi /etc/default/simple
    
    tail -f /var/log/simple/simple.log
