import { MongoClient } from "mongodb";

// Replace the uri string with your MongoDB deployment's connection string.
const uri = "<connection string uri>";
const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    dbName = "sample";
    const database = client.db(dbName);

    // WARNING: Asignación con nombre de entidad eliminada/renombrada
    myVar = "EntityToBeDeleted"
    myVar2 = "EntityNOTToBeDeleted"
    myVar3 = "Entity" + "To" + "Be" + "Deleted"
    myVar4 = myVar3

    // ERROR: (.db(...) | obj).entityName | (.db(...) | obj).collection(entityName)
    database.EntityToBeDeleted.bulkWrite([{updateMany: {filter: {}, update: [{$addFields: { "surname": ""}}], "upsert": true}}])
    database["EntityToBeDeleted"].bulkWrite([{updateMany: {filter: {}, update: [{$addFields: { "surname": ""}}], "upsert": true}}])
    client.db(dbName).EntityToBeDeleted.bulkWrite([{updateMany: {filter: {}, update: [{$addFields: { "surname": ""}}], "upsert": true}}])
    client.db(dbName)["EntityToBeDeleted"].bulkWrite([{updateMany: {filter: {}, update: [{$addFields: { "surname": ""}}], "upsert": true}}])
    client.db("sample").EntityToBeDeleted.bulkWrite([{updateMany: {filter: {}, update: [{$addFields: { "surname": ""}}], "upsert": true}}])
    client.db("sample")["EntityToBeDeleted"].bulkWrite([{updateMany: {filter: {}, update: [{$addFields: { "surname": ""}}], "upsert": true}}])
    database.collection("EntityToBeDeleted");
    database.collection(myVar3);
    client.db("sample").collection("EntityToBeDeleted").bulkWrite([{updateMany: {filter: {}, update: [{$addFields: { "surname": ""}}], "upsert": true}}])
    client.db("sample").collection(myVar4).bulkWrite([{updateMany: {filter: {}, update: [{$addFields: { "surname": ""}}], "upsert": true}}])

    NOTdatabase.EntityToBeDeleted.bulkWrite([{updateMany: {filter: {}, update: [{$addFields: { "surname": ""}}], "upsert": true}}])
    NOTdatabase["EntityToBeDeleted"].bulkWrite([{updateMany: {filter: {}, update: [{$addFields: { "surname": ""}}], "upsert": true}}])
    database.EntityNOTToBeDeleted.bulkWrite([{updateMany: {filter: {}, update: [{$addFields: { "surname": ""}}], "upsert": true}}])
    client.db(dbName).EntityNOTToBeDeleted.bulkWrite([{updateMany: {filter: {}, update: [{$addFields: { "surname": ""}}], "upsert": true}}])
    client.db("sample").EntityNOTToBeDeleted.bulkWrite([{updateMany: {filter: {}, update: [{$addFields: { "surname": ""}}], "upsert": true}}])
    const var1 = database.collection("movies");
    database.collection(myVar2);
    client.db("sample").collection("EntityNOTToBeDeleted").bulkWrite([{updateMany: {filter: {}, update: [{$addFields: { "surname": ""}}], "upsert": true}}])

    // De momento no warning con esto.
    randomFunction1("EntityToBeDeleted", true)
    randomFunction2(false, "EntityNOTToBeDeleted")
    randomFunction3("Entity" + "To" + "Be" + "Deleted", true)
    randomFunction4(true, "Entity" + "To" + "Be" + "Deleted", false)
    randomFunction5(true, "Entity" + "To" + "Be" + "Deleted", false, false, false)

  } finally {
    await client.close();
  }
}

run().catch(console.dir);
