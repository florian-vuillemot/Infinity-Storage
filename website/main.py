from flask import Flask, render_template, request, session
app = Flask(__name__)
app.secret_key = 'any random string'


@app.route('/')
def hello_world():
    return render_template('index.html')


@app.route('/load_info')
def search_database():
    db_name = request.values.get('db_name')
    username = request.values.get('username')
    password = request.values.get('password')
    rq = request.values.get('rq')
    if not db_name or not username or not password or not rq:
        return render_template('error.html')
    try:
        db_fct = {
            'mariadb': _mariadb,
            'mongodb': _mongo
            }
        res = db_fct[db_name](rq)
    except:
        return render_template('error.html')
    return render_template('index.html', res=res)


def _mariadb(sql):
    import pymysql.cursors
    connection = pymysql.connect(host='',
                                 user=session['username'],
                                 password=session['password'],
                                 db='heroes',
                                 charset='utf8mb4',
                                 cursorclass=pymysql.cursors.DictCursor)

    with connection.cursor() as cursor:
        cursor.execute(sql)
        if "select" in sql.lower():
            return cursor.fetchall()
        connection.commit()
        return None


def _mongo(rq):
    import pymongo
    myclient = pymongo.MongoClient("mongodb://localhost:27017/")
    if "db." == rq[:3]:
        rq = rq[3:]
    res = eval(f"myclient['heroes'].{rq}")
    if 'find' in rq.lower():
        return res
    return None
