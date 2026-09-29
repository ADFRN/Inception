FROM debian:bookworm

RUN apt-get update && apt-get install -y --no-install-recommends \
		mariadb-server \
		&& rm -rf /var/lib/apt/lists/*

COPY conf/99-inception.cnf /etc/mysql/mariadb.conf.d/99-inception.cnf
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
