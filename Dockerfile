FROM debian:buster-slim
LABEL maintainer="wekan"

# Declare Arguments
ARG DEBUG
ARG NODE_VERSION
ARG METEOR_RELEASE
ARG METEOR_EDGE
ARG USE_EDGE
ARG NPM_VERSION
ARG FIBERS_VERSION
ARG ARCHITECTURE
ARG SRC_PATH
ARG WITH_API
ARG MATOMO_ADDRESS
ARG MATOMO_SITE_ID
ARG MATOMO_DO_NOT_TRACK
ARG MATOMO_WITH_USERNAME
ARG BROWSER_POLICY_ENABLED
ARG TRUSTED_URL
ARG WEBHOOKS_ATTRIBUTES
ARG OAUTH2_ENABLED
ARG OAUTH2_CLIENT_ID
ARG OAUTH2_SECRET
ARG OAUTH2_SERVER_URL
ARG OAUTH2_AUTH_ENDPOINT
ARG OAUTH2_USERINFO_ENDPOINT
ARG OAUTH2_TOKEN_ENDPOINT
ARG OAUTH2_ID_MAP
ARG OAUTH2_USERNAME_MAP
ARG OAUTH2_FULLNAME_MAP
ARG OAUTH2_EMAIL_MAP
ARG OAUTH2_ID_TOKEN_WHITELIST_FIELDS
ARG OAUTH2_REQUEST_PERMISSIONS
ARG LDAP_ENABLE
ARG LDAP_PORT
ARG LDAP_HOST
ARG LDAP_BASEDN
ARG LDAP_LOGIN_FALLBACK
ARG LDAP_RECONNECT
ARG LDAP_TIMEOUT
ARG LDAP_IDLE_TIMEOUT
ARG LDAP_CONNECT_TIMEOUT
ARG LDAP_AUTHENTIFICATION
ARG LDAP_AUTHENTIFICATION_USERDN
ARG LDAP_AUTHENTIFICATION_PASSWORD
ARG LDAP_LOG_ENABLED
ARG LDAP_BACKGROUND_SYNC
ARG LDAP_BACKGROUND_SYNC_INTERVAL
ARG LDAP_BACKGROUND_SYNC_KEEP_EXISTANT_USERS_UPDATED
ARG LDAP_BACKGROUND_SYNC_IMPORT_NEW_USERS
ARG LDAP_ENCRYPTION
ARG LDAP_CA_CERT
ARG LDAP_REJECT_UNAUTHORIZED
ARG LDAP_USER_SEARCH_FILTER
ARG LDAP_USER_SEARCH_SCOPE
ARG LDAP_USER_SEARCH_FIELD
ARG LDAP_SEARCH_PAGE_SIZE
ARG LDAP_SEARCH_SIZE_LIMIT
ARG LDAP_GROUP_FILTER_ENABLE
ARG LDAP_GROUP_FILTER_OBJECTCLASS
ARG LDAP_GROUP_FILTER_GROUP_ID_ATTRIBUTE
ARG LDAP_GROUP_FILTER_GROUP_MEMBER_ATTRIBUTE
ARG LDAP_GROUP_FILTER_GROUP_MEMBER_FORMAT
ARG LDAP_GROUP_FILTER_GROUP_NAME
ARG LDAP_UNIQUE_IDENTIFIER_FIELD
ARG LDAP_UTF8_NAMES_SLUGIFY
ARG LDAP_USERNAME_FIELD
ARG LDAP_FULLNAME_FIELD
ARG LDAP_MERGE_EXISTING_USERS
ARG LDAP_SYNC_USER_DATA
ARG LDAP_SYNC_USER_DATA_FIELDMAP
ARG LDAP_SYNC_GROUP_ROLES
ARG LDAP_DEFAULT_DOMAIN
ARG LOGOUT_WITH_TIMER
ARG LOGOUT_IN
ARG LOGOUT_ON_HOURS
ARG LOGOUT_ON_MINUTES
ARG CORS
ARG DEFAULT_AUTHENTICATION_METHOD
ARG WEKAN_UID
ARG WEKAN_GID

# Set the environment variables (defaults where required)
# DOES NOT WORK: paxctl fix for alpine linux: https://github.com/wekan/wekan/issues/1303
# ENV BUILD_DEPS="paxctl"
ENV BUILD_DEPS="apt-utils bsdtar gnupg gosu wget curl bzip2 build-essential python python3 python3-distutils git ca-certificates gcc-7" \
    DEBUG=false \
    NODE_VERSION=v8.15.0 \
    METEOR_RELEASE=1.6.0.1 \
    USE_EDGE=false \
    METEOR_EDGE=1.5-beta.17 \
    NPM_VERSION=latest \
    FIBERS_VERSION=2.0.0 \
    ARCHITECTURE=linux-x64 \
    SRC_PATH=./src/ \
    WITH_API=true \
    MATOMO_ADDRESS="" \
    MATOMO_SITE_ID="" \
    MATOMO_DO_NOT_TRACK=true \
    MATOMO_WITH_USERNAME=false \
    BROWSER_POLICY_ENABLED=true \
    TRUSTED_URL="" \
    WEBHOOKS_ATTRIBUTES="" \
    OAUTH2_ENABLED=false \
    OAUTH2_CLIENT_ID="" \
    OAUTH2_SECRET="" \
    OAUTH2_SERVER_URL="" \
    OAUTH2_AUTH_ENDPOINT="" \
    OAUTH2_USERINFO_ENDPOINT="" \
    OAUTH2_TOKEN_ENDPOINT="" \
    OAUTH2_ID_MAP="" \
    OAUTH2_USERNAME_MAP="" \
    OAUTH2_FULLNAME_MAP="" \
    OAUTH2_EMAIL_MAP="" \
    OAUTH2_ID_TOKEN_WHITELIST_FIELDS=[] \
    OAUTH2_REQUEST_PERMISSIONS=[openid] \
    LDAP_ENABLE=false \
    LDAP_PORT=389 \
    LDAP_HOST="" \
    LDAP_BASEDN="" \
    LDAP_LOGIN_FALLBACK=false \
    LDAP_RECONNECT=true \
    LDAP_TIMEOUT=10000 \
    LDAP_IDLE_TIMEOUT=10000 \
    LDAP_CONNECT_TIMEOUT=10000 \
    LDAP_AUTHENTIFICATION=false \
    LDAP_AUTHENTIFICATION_USERDN="" \
    LDAP_AUTHENTIFICATION_PASSWORD="" \
    LDAP_LOG_ENABLED=false \
    LDAP_BACKGROUND_SYNC=false \
    LDAP_BACKGROUND_SYNC_INTERVAL=100 \
    LDAP_BACKGROUND_SYNC_KEEP_EXISTANT_USERS_UPDATED=false \
    LDAP_BACKGROUND_SYNC_IMPORT_NEW_USERS=false \
    LDAP_ENCRYPTION=false \
    LDAP_CA_CERT="" \
    LDAP_REJECT_UNAUTHORIZED=false \
    LDAP_USER_SEARCH_FILTER="" \
    LDAP_USER_SEARCH_SCOPE="" \
    LDAP_USER_SEARCH_FIELD="" \
    LDAP_SEARCH_PAGE_SIZE=0 \
    LDAP_SEARCH_SIZE_LIMIT=0 \
    LDAP_GROUP_FILTER_ENABLE=false \
    LDAP_GROUP_FILTER_OBJECTCLASS="" \
    LDAP_GROUP_FILTER_GROUP_ID_ATTRIBUTE="" \
    LDAP_GROUP_FILTER_GROUP_MEMBER_ATTRIBUTE="" \
    LDAP_GROUP_FILTER_GROUP_MEMBER_FORMAT="" \
    LDAP_GROUP_FILTER_GROUP_NAME="" \
    LDAP_UNIQUE_IDENTIFIER_FIELD="" \
    LDAP_UTF8_NAMES_SLUGIFY=true \
    LDAP_USERNAME_FIELD="" \
    LDAP_FULLNAME_FIELD="" \
    LDAP_MERGE_EXISTING_USERS=false \
    LDAP_SYNC_USER_DATA=false \
    LDAP_SYNC_USER_DATA_FIELDMAP="" \
    LDAP_SYNC_GROUP_ROLES="" \
    LDAP_DEFAULT_DOMAIN="" \
    LOGOUT_WITH_TIMER=false \
    LOGOUT_IN="" \
    LOGOUT_ON_HOURS="" \
    LOGOUT_ON_MINUTES="" \
    CORS="" \
    DEFAULT_AUTHENTICATION_METHOD=""

RUN \
    set -o xtrace && \
    # Add non-root user wekan
    groupadd -g ${WEKAN_GID} wekan && \
    useradd --system -m -u ${WEKAN_UID} -g ${WEKAN_GID} wekan && \
    mkdir -p /home/wekan/app/.meteor && \
    \
    # OS dependencies
    apt-get update -y && apt-get install -y --no-install-recommends ${BUILD_DEPS} && \
    \
    # Meteor installer doesn't work with the default tar binary, so using bsdtar while installing.
    # https://github.com/coreos/bugs/issues/1095#issuecomment-350574389
    cp $(which tar) $(which tar)~ && \
    ln -sf $(which bsdtar) $(which tar) && \
    \
    # Download nodejs
    wget https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-${ARCHITECTURE}.tar.gz && \
    wget https://nodejs.org/dist/${NODE_VERSION}/SHASUMS256.txt.asc && \
    # Verify nodejs authenticity
    grep ${NODE_VERSION}-${ARCHITECTURE}.tar.gz SHASUMS256.txt.asc | shasum -a 256 -c - && \
    rm -f SHASUMS256.txt.asc && \
    \
    # Install Node
    tar xvzf node-${NODE_VERSION}-${ARCHITECTURE}.tar.gz && \
    rm node-${NODE_VERSION}-${ARCHITECTURE}.tar.gz && \
    mv node-${NODE_VERSION}-${ARCHITECTURE} /opt/nodejs && \
    ln -s /opt/nodejs/bin/node /usr/bin/node && \
    ln -s /opt/nodejs/bin/npm /usr/bin/npm && \
    \
    # Install Node dependencies
    npm install -g npm@${NPM_VERSION} && \
    npm install -g node-gyp && \
    npm install -g fibers@${FIBERS_VERSION}

COPY \
    src/.meteor/.finished-upgraders \
    src/.meteor/.id \
    src/.meteor/cordova-plugins \
    src/.meteor/packages \
    src/.meteor/platforms \
    src/.meteor/release \
    src/.meteor/versions \
    /home/wekan/app/.meteor/

COPY \
    src/fix-download-unicode/cfs_access-point.txt \
    /home/wekan/app/fix-download-unicode/cfs_access-point.txt

COPY \
    src/package.json \
    /home/wekan/app/package.json

RUN \
    # Change user to wekan and install meteor
    cd /home/wekan/ && \
    chown wekan:wekan --recursive /home/wekan && \
    curl "https://install.meteor.com" -o /home/wekan/install_meteor.sh && \
    sed -i 's/VERBOSITY="--silent"/VERBOSITY="--progress-bar"/' ./install_meteor.sh && \
    echo "Starting meteor ${METEOR_RELEASE} installation...   \n" && \
    chown wekan:wekan /home/wekan/install_meteor.sh && \
    \
    # Check if opting for a release candidate instead of major release
    if [ "$USE_EDGE" = false ]; then \
      gosu wekan:wekan sh /home/wekan/install_meteor.sh; \
    else \
      gosu wekan:wekan git clone --recursive --depth 1 -b release/METEOR@${METEOR_EDGE} git://github.com/meteor/meteor.git /home/wekan/.meteor; \
    fi;

RUN \
    # Get additional packages
    mkdir -p /home/wekan/app/packages && \
    chown wekan:wekan --recursive /home/wekan && \
    cd /home/wekan/app/packages && \
    gosu wekan:wekan git clone --depth 1 -b master git://github.com/wekan/flow-router.git kadira-flow-router && \
    gosu wekan:wekan git clone --depth 1 -b master git://github.com/meteor-useraccounts/core.git meteor-useraccounts-core && \
    gosu wekan:wekan git clone --depth 1 -b master git://github.com/wekan/meteor-accounts-cas.git && \
    gosu wekan:wekan git clone --depth 1 -b master git://github.com/wekan/wekan-ldap.git && \
    gosu wekan:wekan git clone --depth 1 -b master git://github.com/wekan/wekan-scrollbar.git && \
    sed -i 's/api\.versionsFrom/\/\/api.versionsFrom/' /home/wekan/app/packages/meteor-useraccounts-core/package.js && \
    cd /home/wekan/.meteor && \
    gosu wekan:wekan /home/wekan/.meteor/meteor -- help;
    # We dont need openapi

RUN \
    # Build app
    cd /home/wekan/app && \
    gosu wekan:wekan /home/wekan/.meteor/meteor add standard-minifier-js && \
    gosu wekan:wekan /home/wekan/.meteor/meteor npm install && \
    gosu wekan:wekan /home/wekan/.meteor/meteor build --directory /home/wekan/app_build && \
    cp /home/wekan/app/fix-download-unicode/cfs_access-point.txt /home/wekan/app_build/bundle/programs/server/packages/cfs_access-point.js && \
    chown wekan:wekan /home/wekan/app_build/bundle/programs/server/packages/cfs_access-point.js && \
    cd /home/wekan/app_build/bundle/programs/server/ && \
    gosu wekan:wekan npm install && \
    \
    # Put back the original tar
    mv $(which tar)~ $(which tar)
    # Cleanup
   # apt-get remove --purge -y ${BUILD_DEPS} && \
   # apt-get autoremove -y && \
   # rm -R /var/lib/apt/lists/* && \
   # rm /home/wekan/install_meteor.sh

ENV PORT=3000
EXPOSE $PORT
USER wekan
WORKDIR /home/wekan/app

CMD ["/home/wekan/.meteor/meteor", "run", "--verbose", "--settings", "settings.json"]
