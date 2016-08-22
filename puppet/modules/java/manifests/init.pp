class java (
	$java_root = "/opt/java",
	$java_home = "/opt/java/default",
	$java_install = "/opt/java/jdk1.8.0_92",
	$java_url = "http://download.oracle.com/otn-pub/java/jdk/8u92-b14/jdk-8u92-linux-x64.tar.gz",
	) {

	exec { "download-java":
		command => "wget --no-cookies --no-check-certificate --header \"Cookie: oraclelicense=accept-securebackup-cookie\" \"${java_url}\" -O /tmp/jdk.tar.gz",
	}

	exec { "delete-java":
		command => "rm -rf ${java_root}",
		before => File["create-java-dir"],
	}

	file { "create-java-dir" :
		path => "${java_root}",
		ensure => "directory",
		before => Exec["install-java"],
	}

	exec { "install-java":
		command => "tar -xzvf /tmp/jdk.tar.gz -C ${java_root}/ && rm -f /tmp/jdk.tar.gz",
		require => Exec["download-java"],
	}

	file { "java-symlink":
		path => "${java_home}",
		ensure => "link",
		target => "${java_install}",
		require => Exec["install-java"],
	}

	file { "java-env":
		path => "/etc/profile.d/java.sh",
		content => "export JAVA_HOME=/opt/java/default\nexport PATH=\${PATH}:\${JAVA_HOME}/bin\n",
	}
}