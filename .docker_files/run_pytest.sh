#!/usr/bin/env bash
LOG_DIR=${LOG_ODOO:-/var/log/odoo}
TEST_DIR=${1:-/mnt/extra-addons}

cd $LOG_DIR

pytest $TEST_DIR -v --junit-xml=${LOG_DIR}/junit.xml
