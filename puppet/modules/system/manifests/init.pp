class system {

   $packages = ["curl", "vim", "git", "tofrodos"]

   package { $packages:
      ensure => "installed",
   }
}