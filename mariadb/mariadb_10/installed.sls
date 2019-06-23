generic_installed:
    pkg.installed:
        - name: software-properties-common

mariadb_repo:
    pkgrepo.managed:
       - name: "deb [arch=amd64,arch=amd64,i386,ppc64el]i386,ppc64el] http://mariadb.mirrors.ovh.net/MariaDB/repo/10.4/ubuntu bionic main"
       - keyserver: hkp://keyserver.ubuntu.com:80
       - keyid: 0xF1656F24C74CD1D8

mariadb_installed:
    pkg.installed:
        - name: mariadb-server
        - refresh: True

