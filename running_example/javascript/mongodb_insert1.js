import { MongoClient } from "mongodb";

// Replace the uri string with your MongoDB deployment's connection string.

const uri = "<connection string uri>";
const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const database = client.db("running_example");
    const tickets = database.collection("Ticket");

    // create a document to insert
    const doc = {
      message: "Record of a Shriveled Datum",
      repository_id: "No bytes, no problem. Just insert a document, in MongoDB",
    }

    const result = await tickets.insertOne(doc);
    console.log(`A document was inserted with the _id: ${result.insertedId}`);
  } finally {
    await client.close();
  }
}

run().catch(console.dir);
