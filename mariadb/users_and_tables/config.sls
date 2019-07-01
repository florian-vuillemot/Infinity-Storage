include:
    - mariadb_10.installed

# Allow foreign connection
/etc/mysql/my.cnf:
    file.managed:
        - source:
            - 'salt://conf/my.cnf'

restart_mariadb_for_conf:
    cmd.run:
        - name: systemctl restart mariadb

create_database:
    cmd.run:
        - name: mysql -e "CREATE DATABASE IF NOT EXISTS heroes"

create_person_table:
    cmd.run:
        - name: mysql -e "CREATE TABLE IF NOT EXISTS heroes.person (ID INT NOT NULL, FirstPerson VARCHAR(100), LastName VARCHAR(100))"

create_job_table:
    cmd.run:
        - name: mysql -e "CREATE TABLE IF NOT EXISTS heroes.job (ID INT NOT NULL, job_name VARCHAR(100))"

{% for user in pillar['users'] %}
create_user:
    cmd.run:
        - name: mysql -e "CREATE USER IF NOT EXISTS {{ user }} identified by '{{ pillar['password'][user] }}'"

grant_user_for_job:
    cmd.run:
        - name: mysql -e "GRANT select,insert,update,delete ON heroes.job TO {{ user }}"

grant_user_for_person:
    cmd.run:
        - name: mysql -e "GRANT select,insert,update,delete ON heroes.person TO {{ user }}"
{% endfor %}
