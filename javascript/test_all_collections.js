import { MongoClient } from "mongodb";

// Replace the uri string with your MongoDB deployment's connection string.
const uri = "<connection string uri>";
const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    dbName = "sample";

    const DbObject1 = client.db(dbName);
    const DbObject2 = DbObject1;
    const DbObject3 = DbObject2;

    DbObject1.getAllCollections();
    DbObject2.listCollections();
    DbObject3.getCollectionNames();

    client.db(dbName).getAllCollections();
    client.db(dbName).listCollections();
    client.db(dbName).getCollectionNames();

    getAllCollections();
    listCollections();
    getCollectionNames();

    randomObj.randomMethod(dbName).getAllCollections();
    randomObj.randomMethod(dbName).listCollections();
    randomObj.randomMethod(dbName).getCollectionNames();

    RandomConst.getAllCollections();
    RandomConst.listCollections();
    RandomConst.getCollectionNames();

  } finally {
    await client.close();
  }
}

run().catch(console.dir);
