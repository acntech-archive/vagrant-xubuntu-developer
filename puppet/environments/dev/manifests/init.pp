#
# Build AcnTech Vagrant box
#

Exec {
	path => [ '/sbin', '/bin', '/usr/sbin', '/usr/bin' ]
}

class apt {

  exec { "apt-update":
    command => "/usr/bin/apt-get update"
  }

  # Ensure apt is setup before running apt-get update
  Apt::Key <| |> -> Exec["apt-update"]
  Apt::Source <| |> -> Exec["apt-update"]

  # Ensure apt-get update has been run before installing any packages
  Exec["apt-update"] -> Package <| |>
}

include system
include docker
include java
include maven
include ant
include intellij
