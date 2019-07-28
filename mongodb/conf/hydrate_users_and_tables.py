import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")


############################################
##### Database, collection and data ########
############################################

def insert(collection, data):
    for d in data:
        if not collection.find_one(d):
            collection.insert_one(d)

mydb = myclient["heroes"]

data = [
    {"id": 1, "FirstName": "John", "LastName": "Snow"},
    {"id": 2, "FirstName": "Harry", "LastName": "Potter"},
    {"id": 3, "FirstName": "Tony", "LastName": "Stark"},
    {"id": 4, "FirstName": "Fox", "LastName": "Mulder"}
]
insert(mydb["person"], data)


data = [
    {"id": 1, "job_name": "wizard"},
    {"id": 2, "job_name": "fbi agent"},
    {"id": 3, "job_name": "night's watch"},
    {"id": 4, "job_name": "wealthy"}
]
insert(mydb["job"], data)


############################################
############# Users and Role ###############
############################################

mydb = myclient['admin']

# Create admin

try:
    mydb.command("createUser", "admin", pwd="pwd",
                 roles=[{"role": "userAdminAnyDatabase", "db": "admin"}, "readWriteAnyDatabase"],
                 authenticationRestrictions=[{
                     "clientSource": ["127.0.0.1"]
                 }])
except Exception as e:
    print(e)

# Create other user with role

def createUserAndRole(username):
    try:
        mydb = myclient["admin"]
        rolename = username + "Role"
        mydb.command("createRole", rolename,
                     privileges=[
                         {
                             "resource": {"db": "heroes", "collection": username},
                             "actions": ["find", "insert", "update", "remove"]
                         }
                     ],
                     roles=[],
                     authenticationRestrictions=[{
                         "clientSource": ["192.168.0.31"]
                     }])
        mydb.command("createUser", username,
                     pwd=username,
                     roles=[rolename])
    except Exception as e:
        print(e)

createUserAndRole("person")
createUserAndRole("job")
