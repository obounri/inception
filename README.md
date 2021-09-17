#  System Administration related project using Docker.

This project consists in having to set up an infrastructure composed of different
services (NGINX, WordPress, MariaDB, each service running in a dedicated container) under specific rules, using docker-compose, with volumes for the WordPress
database and website files.

The containers have to restart in case of a crash.
