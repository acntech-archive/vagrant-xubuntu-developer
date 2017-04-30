class intellij (
	$intellij_version = "2017.1.2",
	$intellij_home = "/opt/intellij",
	$intellij_archive = "/tmp/intellij.tar.gz",
	$intellij_edition = "ideaIC",
	$intellij_install = "${intellij_home}/${intellij_edition}-${intellij_version}",
	) {

	exec { "download-intellij":
		command => "wget --no-cookies --no-check-certificate https://download.jetbrains.com/idea/${intellij_edition}-${$intellij_version}.tar.gz -O ${intellij_archive}",
		timeout => 1800,
		unless => ["test -d ${intellij_install}"],
	}

	file { ["${intellij_home}", "${intellij_install}"]:
		ensure => directory,
		owner => "vagrant",
		group => "vagrant",
		before => Exec["intellij-install"],
	}

	exec { "intellij-install":
		command => "tar -zxvf ${intellij_archive} --strip-components 1 -C ${intellij_install} && rm -f ${intellij_archive}",
		require => Exec["download-intellij"],
		unless => ["test ! -f ${intellij_archive}"],
	}

	file { "intellij-symlink":
		path => "${intellij_home}/${intellij_edition}",
		ensure => "link",
		target => "${intellij_install}",
		require => Exec["intellij-install"],
	}

	file { "intellij-default-symlink":
		path => "${intellij_home}/default",
		ensure => "link",
		target => "${intellij_home}/${intellij_edition}",
		require => File["intellij-symlink"],
	}

	file { "intellij-icon":
		path => "/usr/share/applications/intellij-${intellij_edition}.desktop",
		source => "/vagrant/puppet/modules/intellij/files/intellij.desktop",
		require => File["intellij-default-symlink"],
	}
}
