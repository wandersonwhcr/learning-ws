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

exec { "nodejs : key":
    unless  => "apt-key finger 68576280 2>/dev/null | grep .",
    command => "wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -",
}

file { "nodejs : list":
    path    => "/etc/apt/sources.list.d/nodejs.list",
    content => "deb https://deb.nodesource.com/node_11.x stretch main",
    require => Package["apt-get : https"],
    before  => Exec["apt-get : update"],
}

package { "nodejs":
    name    => "nodejs",
    require => [
        File["nodejs : list"],
        Exec["apt-get : update"],
    ],
}
