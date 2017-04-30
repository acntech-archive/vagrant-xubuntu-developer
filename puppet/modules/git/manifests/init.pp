class git {

   package { "git-install":
      name => "git",
      ensure => "installed",
   }

   file { "git-config":
      path => "/home/vagrant/.gitconfig",
      source => "/vagrant/puppet/modules/git/files/gitconfig",
      owner => "vagrant",
      group => "vagrant",
      require => Package["git-install"],
   }
}