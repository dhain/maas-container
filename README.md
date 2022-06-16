Run Canonical's MAAS in a Container
===================================

Quick Start
-----------

    for component in postgres maas; do
        kubectl create -f kubernetes/${component}.yaml
    done

Notes
-----

* MAAS is installed in the container using the ppa.
* Systemctl is [docker-systemctl-replacement][1].
* We patch systemctl to fix an issue with env substitution in dhcpd ExecStart

[1]: https://github.com/gdraheim/docker-systemctl-replacement
