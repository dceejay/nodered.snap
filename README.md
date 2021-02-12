# Node-RED Snap package

[![platform](https://img.shields.io/badge/platform-Node--RED-red)](https://nodered.org)
[![GitHub version](https://badge.fury.io/gh/node-red%2Fnode-red.svg)](https://badge.fury.io/gh/node-red%2Fnode-red)

The Node-RED graphical wiring tool for Low-code programming of event-driven applications.
Packaged as a Core18 based Ubuntu Snap, intended for multiple architectures.

Listens on port 1880 and runs as as service in strict mode by default.

By default builds get automatically placed in the edge channel, and then promoted to the stable channel manually.

### Restrictions

When installed as a Snap package, it will run in a secure container that does
not have access to any external facilities that may be needed for you to use, such as:

 - You cannot install extra nodes that require natively compiled code as the build tools are not built in.
 - You cannot use projects mode as that requires comman line access to git and that is also not built in.
 - access to the main system storage/disk
 - `gcc` - needed to compile any binary components of nodes you want to install
 - `git` - needed if you want to use the Projects feature
 - No direct access to gpio hardware
 - No access to any external commands your flows want to use with the Exec node (for example).

You may be able relax this by installing the snap in `--classic` mode but this is not advised, and Canonical have tightened the scope recently and this is no longer possible unless in development mode. (IE you have to clone this and build the snap yourself)

**ping**: If you want to use the ping node you must manually connect the network-observe interface.

    sudo snap connect node-red:network-observe


#### Installing

    snap install node-red

if installing on a Pi please ensure the core is also at the latest level

    sudo snap install core
    or
    sudo snap refresh core

When the snap is running you can view the Node-RED log using

    journalctl -f -u snap.node-red*

You can also stop and restart the application by

    snap disable node-red
    snap enable node-red

Currently the ONLY serial support is for /dev/ttyS0 style ports.
USB serial ports (hot-pluggable) are not yet supported by Snap.


#### Configuration

The **settings.js** and **flows.json** file are located in the `/root/snap/node-red/current/` directory.
If you do need to read and write files - this is the only directory path you will have access to from outside
the secure container.

**Note:** The path to the flows file is currently fixed to `flows.json` in [start.sh](nodered.snap/blob/master/snap/local/settings/start.sh) and therefore cannot be changed in `settings.js`.

To install any extra nodes, the best option is to use the Manage Palette option in the editor.
To install via the command line you can

    sudo su -
    cd /root/snap/node-red/current/
    node-red.npm i --unsafe-perm node-red-contrib-my-great-node-name
    snap restart node-red

The base port can be set by the `$PORT` environment variable, or in the `settings.js` file.


#### Building

To re-build locally, modify the snapcraft.yaml as required, and then execute `build_snap.sh`
