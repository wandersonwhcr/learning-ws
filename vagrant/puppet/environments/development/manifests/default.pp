Exec {
    path    => ["/usr/bin", "/bin", "/usr/sbin", "/sbin"],
    timeout => 0,
}

Package {
    require => Exec["apt-get : update"],
    before  => Exec["apt-get : autoremove"],
}

exec { "apt-get : https-update":
    command => "apt-get update",
}

package { "apt-get : https":
    name    => "apt-transport-https",
    require => Exec["apt-get : https-update"],
}

exec { "apt-get : update":
    command => "apt-get update",
    require => Package["apt-get : https"],
}

exec { "apt-get : upgrade":
    command => "apt-get dist-upgrade -y",
    require => Exec["apt-get : update"],
}

exec { "apt-get : autoremove":
    command => "apt-get autoremove -q -y",
    require => Exec["apt-get : upgrade"],
}

package { "linux-headers":
    name => "linux-headers-amd64",
}
