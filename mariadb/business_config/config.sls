create_database:
    cmd.run:
        - name: mysql -e "CREATE DATABASE IF NOT EXISTS hero"

create_person_table:
    cmd.run:
        - name: mysql -e "CREATE TABLE IF NOT EXISTS hero.person (ID INT NOT NULL, FirstPerson VARCHAR(100), LastName VARCHAR(100))"

create_job_table:
    cmd.run:
        - name: mysql -e "CREATE TABLE IF NOT EXISTS hero.job (ID INT NOT NULL, job_name VARCHAR(100))"

{% for user in pillar['users'] %}
create_user:
    cmd.run:
        - name: mysql -e "CREATE USER IF NOT EXISTS {{ user }} identified by '{{ pillar['password'][user] }}'"

grant_user_for_job:
    cmd.run:
        - name: mysql -e "GRANT select,insert,update,delete ON hero.job TO {{ user }}"

grant_user_for_person:
    cmd.run:
        - name: mysql -e "GRANT select,insert,update,delete ON hero.person TO {{ user }}"
{% endfor %}
