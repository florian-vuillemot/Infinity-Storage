import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")

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



