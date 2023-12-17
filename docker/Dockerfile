FROM ubuntu:focal

ARG TARGETARCH

RUN apt-get update \
  && apt-get install -y wget gcc make openssl libffi-dev libgdbm-dev libsqlite3-dev libssl-dev zlib1g-dev \
  && apt-get install -y python python-pip \
  && apt-get clean

RUN apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        npm \
        git \
        vim \
        wget \
        python-gevent \
        python-pyinotify \
        python-renderpm \
        python-renderpm \
        python-watchdog \
    && pip install psycogreen==1.0 

RUN set -x; apt-get install -y wkhtmltopdf node-less && npm install -g lessc

# Install Odoo
ENV ODOO_VERSION 10.0
ENV ODOO_RELEASE latest
RUN set -x; \
        curl -o odoo.deb -SL http://nightly.odoo.com/${ODOO_VERSION}/nightly/deb/odoo_${ODOO_VERSION}.${ODOO_RELEASE}_all.deb \
        && curl -o odoo.sha -SL http://nightly.odoo.com/${ODOO_VERSION}/nightly/deb/odoo_${ODOO_VERSION}.${ODOO_RELEASE}_amd64.changes \
        && echo $(cat odoo.sha | grep -E -e "^\s[a-z,0-9]{40}\s.*_all\.deb$" | cut -f 2 -d " ") 'odoo.deb' | sha1sum -c - \
        && dpkg --force-depends -i odoo.deb \
        && apt-get update \
        && apt-get -y install -f --no-install-recommends \
        && rm -rf /var/lib/apt/lists/* odoo.deb odoo.sha


# Install PostgreSQL Server
# RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
#     && sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" > /etc/apt/sources.list.d/PostgreSQL.list' \
#     && apt-get -y update \
#     && apt-get install postgresql-10 -y

# install latest postgresql-client
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ jammy-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
    && GNUPGHOME="$(mktemp -d)" \
    && export GNUPGHOME \
    && repokey='B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8' \
    && gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "${repokey}" \
    && gpg --batch --armor --export "${repokey}" > /etc/apt/trusted.gpg.d/pgdg.gpg.asc \
    && gpgconf --kill all \
    && rm -rf "$GNUPGHOME" \
    && apt-get update  \
    && apt-get install --no-install-recommends -y postgresql-client \
    && rm -f /etc/apt/sources.list.d/pgdg.list \
    && rm -rf /var/lib/apt/lists/*


# Copy entrypoint script and Odoo configuration file
COPY ./entrypoint.sh /
COPY ./config/odoo.conf /etc/odoo/

RUN chmod +x entrypoint.sh



ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "odoo" ]