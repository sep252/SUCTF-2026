#!/bin/bash
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < /wms.sql || true
exit 0
