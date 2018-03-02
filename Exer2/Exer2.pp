#Developed by: Nestor B. Gramata Jr.
#Created: 20170228
#Tested on CentOS 6.7 and 6.9

    #Install vim - used allow_virtual so Puppet resolves vim as package name for CentOS
    package { 'vim':
      ensure        => installed,
      allow_virtual => true,
    }

    #Install curl
    package { 'curl':
      ensure => installed,
    }

    #Install git
    package { 'git':
      ensure => installed,
    }

    #User Credential: monitor/df
    user { 'monitor':
      ensure     =>  'present',
      shell      =>  '/bin/bash',
      home       =>  '/home/monitor',
      comment    =>  'monitor',
      password   =>  '$6$jR3HJ38peVbpvJF3$P9G7k/y9ejPWfW2j/.r6dnvqx1x0vblINDGoRvIMFnqvFhU8j6B.itWCaX8dNR6GYvS59eo4VHRLPOz9ejUSz0',
      managehome =>  true,
    }

    #Create dir /home/monitor/scripts/
    file { '/home/monitor/scripts/':
      ensure => 'directory',
      owner  => 'monitor',
      group  => 'monitor',
      mode   => '0750',
    }

    #Download from github -- copy memory_check to scripts dir
    exec{'get_memory_check':
      command => 'curl -q https://raw.githubusercontent.com/jellyseafood/Exercise_Repo20182402/master/Exer1/memory_check -o /home/monitor/scripts/memory_check',
      path    => '/usr/bin/:/bin/:/sbin/',
      creates => '/home/monitor/scripts/memory_check',
    }
    file{'/home/monitor/scripts/memory_check':
      owner   => 'monitor',
      group   => 'monitor',
      mode    => '0755',
      require => Exec['get_memory_check'],
    }

    #Create dir /home/monitor/src/
    file { '/home/monitor/src/':
      ensure => 'directory',
      owner  => 'monitor',
      group  => 'monitor',
      mode   => '0750',
    }

    #Create soft link named my_memory_check in src dir
    file { '/home/monitor/src/my_memory_check':
      ensure => 'link',
      target => '/home/monitor/scripts/memory_check',
    }

    #Set crontab sched every 10 mins
    #used -c 20 -w 10 -e nestor.gramata.jr@gmail.com for the script
    #used lower values of -c and -w to increase the likelihood of receiving an email (for testing)
    cron { 'monitor_cron':
        ensure  => 'present',
        command => '/home/monitor/src/my_memory_check -c 20 -w 10 -e nestor.gramata.jr@gmail.com',
        user    => 'monitor',
        minute  => '*/10',
    }

    #Set timezone to PHT
    exec{'timezone_PHT':
      command => 'unlink /etc/localtime; \
                 ln -s /usr/share/zoneinfo/Asia/Manila /etc/localtime',
      path    => '/usr/bin/:/bin/:/sbin/',
      onlyif  => 'test "$( readlink /etc/localtime )" != "/usr/share/zoneinfo/Asia/Manila"',
    }
    
    #Set hostname to bpx.server.local
    exec{'hostname_change':
      command => 'sed -i "s/$( hostname )/bpx.server.local/g" /etc/hosts; \
                 sed -i "s/HOSTNAME=.*/HOSTNAME=bpx.server.local/g" /etc/sysconfig/network; \
                 hostname bpx.server.local; \
                 service network restart',
      path    => '/usr/bin/:/bin/:/sbin/',
      onlyif  => 'test "$( hostname )" != "bpx.server.local"',
    }