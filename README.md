# ncdu-web-viewer

[![Docker Pulls](https://img.shields.io/docker/pulls/abesesr/ncdu-web-viewer.svg)](https://hub.docker.com/r/abesesr/ncdu-web-viewer/)
[![ncdu-web-viewer ci](https://github.com/abes-esr/ncdu-web-viewer/actions/workflows/build-test-pubtodockerhub.yml/badge.svg)](https://github.com/abes-esr/ncdu-web-viewer/actions/workflows/build-test-pubtodockerhub.yml)


Web interface used to visualize and navigate through [ncdu](https://dev.yorhel.nl/ncdu) results (Ncdu is a disk usage analyzer).

This tool could be used internaly at [Abes](https://abes.fr) for analyze and cleanup steps when manipulating massive data. Thanks to the web interface it makes easier to give this tool to a librarian. Thanks to the ``dump`` feature, it makes easier to analyze very big folder so that only one guy will generate the export/dump of a given folder and all the staff will be able to view it concurrently without generating performance isues on this big folder.

![image](https://github.com/kerphi/ncdu-web-viewer/assets/328244/84be8aaf-1f8e-4231-a458-1a70d6d84046)


## Prerequisites

- docker

## Parameters

- ``NCDU_WEB_VIEWER_SCAN_FROM``: two values are allowed (``folder`` or ``dump``)
  - if ``folder`` (default value) then it will tell ncdu to scan the ``/folder-to-scan/`` folder in the current container.
  - if ``dump``, then it will tell ncdu to import the ``/opt/ncdu-dump-applis.json`` and view its content (instead of scanning a folder).
- ``NCDU_WEB_VIEWER_READONLY``: to enable or disable ncdu readonly feature (``yes`` by default, only used with NCDU_WEB_VIEWER_SCAN_FROM=folder feature)

### Usage : view a folder after scanning it

By default ncdu will scan the folder ``/folder-to-scan/``. This folder is located inside the container. You have to mount the wanted folder as a docker volume to be able to analyze the folder you want.

Example if you want to analyze the ``/applis/`` folder on your docker host: 
```bash
docker run --rm \
  -e NCDU_WEB_VIEWER_SCAN_FROM=folder \
  -e NCDU_WEB_VIEWER_READONLY=no \
  -v /applis/:/folder-to-scan/ \
  -p 3000:3000 abesesr/ncdu-web-viewer:1.0.0
```

Then open your web browser (replace 127.0.0.1 by your server ip): http://127.0.0.1:3000/

### Usage : view a ncdu dump

If you want to visualize a precalculated scan of a folder, you can use the ``dump`` feature.

You first have to generate a ncdu dump this way: 
```bash
ssh my-server-to-scan
ncdu -o /tmp/ncdu-dump-applis.json /applis/
```

Then (if you want on another server) you have to copy your dump and run ncdu-web-viewer this way:
```bash
ssh my-web-server
scp my-server-to-scan:/tmp/ncdu-dump-applis.json /opt/
docker run --rm \
  -e NCDU_WEB_VIEWER_SCAN_FROM=dump \
  -v /opt/ncdu-dump-applis.json:/ncdu-dump.json \
  -p 3000:3000 abesesr/ncdu-web-viewer:1.0.0
```

Then open your web browser (replace 127.0.0.1 by your server ip): http://127.0.0.1:3000/wetty/

## Developments and debug

To develop or debug ncdu-web-viewer, you can use the docker-compose.yml in the example folder this way: 
```bash
cd example/
docker compose up
```

Then navigate to http://127.0.0.1:3000 or http://127.0.0.1:3001 or http://127.0.0.1:3002 to test the 3 features.

Then CTRL+C, modify the code, and ``docker compose up`` again to test your modification.


## Deployment

This [repository](https://github.com/abes-esr/ncdu-web-viewer-docker/) gives a docker-compose.yml / .env example.

## Generating a new version of this tool

TODO

## Tools used

- [wetty](https://github.com/butlerx/wetty)
- [ncdu](https://dev.yorhel.nl/ncdu)

## See also

- https://pacroy.com/setup-web-terminal-using-wetty-docker-image-dcb1ea75bfaf
- https://github.com/josephpaul0/tdu
- https://github.com/Byron/dua-cli
- https://github.com/konosubakonoakua/ncdu-zig

