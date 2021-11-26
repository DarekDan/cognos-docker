#!/bin/bash

pushd /opt/cognos/bin64 && ./cogconfig.sh -s && popd && tail -F /opt/cognos/logs/cognosserver.log