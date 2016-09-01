class intellij (
	$intellij_version = "2016.2.3",
	$intellij_home = "/opt/intellij",
	$intellij_default = "/opt/intellij/default",
	$intellij_archive = "intellij.tar.gz",
	$intellij_edition = "IC",
	$intellij_install = "${intellij_home}/${intellij_edition}-${intellij_version}",
	$tmp = "/tmp") {

	exec { "download-intellij":
		command => "wget --no-cookies --no-check-certificate https://download.jetbrains.com/idea/idea${intellij_edition}-${$intellij_version}.tar.gz -O ${tmp}/${intellij_archive}",
	}

	file { ["${intellij_home}", "${intellij_install}"]:
		ensure => directory,
		before => Exec["intellij-install"],
	}

	exec { "intellij-install":
		command => "tar -zxvf ${tmp}/${intellij_archive} --strip-components 1 -C ${intellij_install} && rm -f ${tmp}/${intellij_archive}",
		require => Exec["download-intellij"],
	}

	file { "intellij-symlink":
		path => "${intellij_default}",
		ensure => "link",
		target => "${intellij_install}",
		require => Exec["intellij-install"],
	}

	file { "intellij-icon":
		path => "/usr/share/applications/intellij.desktop",
		source => "/vagrant/puppet/modules/intellij/files/intellij.desktop",
	}
}
