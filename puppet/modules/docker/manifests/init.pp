class docker (
	$docker_compose_version = "1.10.0"
	) {

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

	package { "docker-engine-install":
		name => "docker-engine",
		ensure => "installed",
		require => Exec["apt-update"],
	}

	package { "docker-compose-install":
		name => "docker-compose",
		ensure => "installed",
		require => Package["docker-engine-install"],
	}

	user { "docker-group":
		name => "vagrant",
		groups => "docker",
		require => Package["docker-engine-install"],
	}

	exec { "download-docker-compose":
		command => "curl -L https://github.com/docker/compose/releases/download/${docker_compose_version}/docker-compose-$(uname -s)-$(uname -m) > /usr/bin/docker-compose",
		unless => ["which docker-compose && docker-compose -v | grep -q \"version ${docker_compose_version}\""]
	}

	file { "docker-compose-set-executable":
		path => "/usr/bin/docker-compose",
		mode => "0755",
		require => Exec["download-docker-compose"]
	}
}