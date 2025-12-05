#!/bin/bash
# Generate SnowSQL config from pass secrets

CONFIG_DIR="$HOME/.snowsql"
TEMPLATE="$CONFIG_DIR/config.template"
CONFIG="$CONFIG_DIR/config"

# Fetch secrets from pass
USERNAME=$(pass snowsql/username)
QA_ACCOUNT=$(pass snowsql/qa/accountname)
STAGING_ACCOUNT=$(pass snowsql/staging/accountname)
PROD_ACCOUNT=$(pass snowsql/staging/accountname)  # Using same as staging for prod

# Generate config from template
sed -e "s|__USERNAME__|$USERNAME|g" \
    -e "s|__QA_ACCOUNT__|$QA_ACCOUNT|g" \
    -e "s|__STAGING_ACCOUNT__|$STAGING_ACCOUNT|g" \
    -e "s|__PROD_ACCOUNT__|$PROD_ACCOUNT|g" \
    "$TEMPLATE" > "$CONFIG"

chmod 600 "$CONFIG"
echo "✓ SnowSQL config generated from pass secrets"
