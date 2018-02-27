    #install vim - used allow_virtual so Puppet resolves vim as package name for CentOS
    package { 'vim':
      ensure        => installed,
      allow_virtual => true,
    }

    #install curl
    package { 'curl':
      ensure => installed,
    }

    #install git
    package { 'git':
      ensure => installed,
    }

    #creds: monitor/df
    user { 'monitor':
      ensure     =>  'present',
      shell      =>  '/bin/bash',
      home       =>  '/home/monitor',
      comment    =>  'used to run monitoring script',
      password   =>  '$6$jR3HJ38peVbpvJF3$P9G7k/y9ejPWfW2j/.r6dnvqx1x0vblINDGoRvIMFnqvFhU8j6B.itWCaX8dNR6GYvS59eo4VHRLPOz9ejUSz0',
      managehome =>  true,
    }

    #create dir /home/monitor/scripts/
    #download from github -- monitor_check in scripts dir

    #create dir /home/monitor/src/

    #create soft link named my_memory_check in src dir

    #crontab sched every 10 mins

    #Set hostname to bpx.server.local
    #  /etc/sysconfig/network
    #  hostname <name>