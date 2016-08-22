class docker {

	exec { "docker-apt-key":
		command => "apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D",
	}

	file { "docker-apt-repo":
		path => "/etc/apt/sources.list.d/docker.list",
		content => "deb https://apt.dockerproject.org/repo ubuntu-xenial main\n",
		require => Exec["docker-apt-key"],
	}

	exec { "apt-update":
    	command => "/usr/bin/apt-get update",
    	require => File["docker-apt-repo"],
	}

	package { "docker-install":
		name => "docker-engine",
		ensure => "installed",
		require => Exec["apt-update"],
	}

	user { "docker-group":
		name => "vagrant",
		groups => "docker",
		require => Package["docker-install"],
	}
}