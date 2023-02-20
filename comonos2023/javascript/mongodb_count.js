import { MongoClient } from "mongodb";

// Replace the uri string with your MongoDB deployment's connection string.

const uri = "<connection string uri>";
const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const database = client.db("running_example");
    const developers = database.collection("Developer");

    // Estimate the total number of documents in the collection
    // and print out the count.
    const estimate = await developers.estimatedDocumentCount();
    console.log(`Estimated number of documents in the developers collection: ${estimate}`);

    const query = { permissions: "RW" };

    // Find the number of documents that match the specified
    // query, (i.e. with "Canada" as a value in the "countries" field)
    // and print out the count.

    const countCanada = await developers.countDocuments(query);
    console.log(`Number of developers: ${countCanada}`);
  } finally {
    await client.close();
  }
}

run().catch(console.dir);
