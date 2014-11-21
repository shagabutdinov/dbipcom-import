DB-IP.com import sql scripts
----------------------------

Convert csv of "IP address to city" from web site [DB-IP.com](DB-IP.com) to
mysql table.

Usage
=====

1. Download latest "IP address to city" from https://db-ip.com/db/
2. Extract archive
3. Clone this repository or download import.sql file.
4. Put path to ips into very first line of scripts
5. Run script with mysql -u USER -r DATABASE -p < import.sql