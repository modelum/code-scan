import { MongoClient } from "mongodb";

// Replace the uri string with your MongoDB deployment's connection string.

const uri = "<connection string uri>";
const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();

    // define a database and collection on which to run the method
    const database = client.db("running_example");
    const tickets = database.collection("Ticket");

    // specify the document field
    const fieldName = "created_time";

    // specify an optional query document
    const query = { message: "Barbra Streisand" };
    const distinctValues = await tickets.distinct(fieldName, query);
    console.log(distinctValues);

  } finally {
    await client.close();
  }
}

run().catch(console.dir);
