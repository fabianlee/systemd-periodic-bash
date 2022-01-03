# systemd-periodic-bash

Example of running bash script periodically using systemd (either system level or user level).


## for testing one-time run
    env_arg=foo ./simple-bash.sh 2
    
## for periodic run with user-level systemd service
    cd systemd-userlevel
    ./create-simple-userservice.sh
    vi ~/default/simpleservice
    
    tail -f ~/log/simpleservice/*
    
    
## for periodic run with system-level systemd service
    cd systemd-systemlevel
    ./create-simple-service.sh
    vi /etc/default/simpleservice
    
    tail -f /var/log/simpleservice/simple.log
