from pymongo import MongoClient
import pprint

db = MongoClient('mongodb+srv://main_user:8BjRQxoteAI6jFuB@vas.em4dc.mongodb.net/test')['synk']

pp = pprint.PrettyPrinter(indent=1)


for doc in db['IoTObject'].watch():
    pp.pprint(doc['documentKey'])