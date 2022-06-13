Run Canonical's MAAS in a Container
===================================

Quick Start
-----------

    kubectl run maas --image=ghcr.io/dhain/maas:3.1

or

    kubectl create -f maas.yaml

Notes
-----

* MAAS is installed in the container using the ppa. This includes postgresql by
  default, so everything runs in the same container.
* Systemctl is [docker-systemctl-replacement][1].

[1]: https://github.com/gdraheim/docker-systemctl-replacement
