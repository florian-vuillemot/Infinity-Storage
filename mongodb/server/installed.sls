mongodb_repo:
    pkgrepo.managed:
       - name: "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse"
       - keyserver: hkp://keyserver.ubuntu.com:80
       - keyid: 9DA31620334BD75D9DCB49F368818C72E52529D4

mongodb_installed:
    pkg.installed:
        - names:
            - mongodb-org
        - refresh: True

