from pymongo import MongoClient
import pprint

db = MongoClient('mongodb+srv://main_user:8BjRQxoteAI6jFuB@cluster0.em4dc.mongodb.net/test')['todo']

pp = pprint.PrettyPrinter(indent=1)


for doc in db['IoTObject'].watch():
    pp.pprint(doc['documentKey'])