# Website

## Warning:

This website is **ONLY** for test

## How to run

* Install pipenv
* Go in the directory and run `pipenv shell` then `pipenv install`
* Go in `main.py` and enter the hostname/ip of your databases for (mariadb, mongodb)
* You can now run `FLASK_ENV=main.py flask run`
* Go on `http:localhost:5000`

## Command

On this website you have to select your database, enter the username, password and the request.

**Warning:** For MongoDB the request is execute from python code. So run `db.person.findOne(..)` have to be write `db.person.find_one(..)`
