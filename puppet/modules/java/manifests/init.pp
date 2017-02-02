class java (
	$java_root = "/opt/java",
	$java_home = "/opt/java/default",
	$java_install = "/opt/java/jdk1.8.0_111",
	$java_url = "http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.tar.gz",
	) {

	exec { "download-java":
		command => "wget --no-cookies --no-check-certificate --header \"Cookie: oraclelicense=accept-securebackup-cookie\" \"${java_url}\" -O /tmp/jdk.tar.gz",
		timeout => 1800,
		unless => ["test -d ${java_install}"],
	}

	exec { "delete-java":
		command => "rm -rf ${java_root}",
		before => File["create-java-dir"],
	}

	file { "create-java-dir":
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

	exec { "set-default-java":
		command => "update-alternatives --install \"/usr/bin/java\" \"java\" \"/opt/java/default/bin/java\" 1 && update-alternatives --set \"java\" \"/opt/java/default/bin/java\"",
		require => Exec["install-java"],
	}

	exec { "set-default-javac":
		command => "update-alternatives --install \"/usr/bin/javac\" \"javac\" \"/opt/java/default/bin/javac\" 1 && update-alternatives --set \"javac\" \"/opt/java/default/bin/javac\"",
		require => Exec["install-java"],
	}

	exec { "set-rng-to-urandom":
		command => "sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/g' ${java_home}/jre/lib/security/java.security",
		require => Exec["install-java"],
	}

	exec { "set-default-jar":
		command => "update-alternatives --install \"/usr/bin/jar\" \"jar\" \"/opt/java/default/bin/jar\" 1 && update-alternatives --set \"jar\" \"/opt/java/default/bin/jar\"",
		require => Exec["install-java"],
	}

	file { "java-env":
		path => "/etc/profile.d/java.sh",
		content => "export JAVA_HOME=/opt/java/default\nexport PATH=\${PATH}:\${JAVA_HOME}/bin\n",
	}
}