import { MongoClient } from "mongodb";

// Replace the uri string with your MongoDB deployment's connection string.

const uri = "<connection string uri>";
const client = new MongoClient(uri);

async function run() {

  try {
    await client.connect();
    const database = client.db("running_example");
    const repositories = database.collection("Repository");

    // Query for all movies with a title containing the string "Santa"
    const query = { title: { $regex: "git" } };
    const result = await repositories.deleteMany(query);
    console.log("Deleted " + result.deletedCount + " documents");

  } finally {
    await client.close();
  }
}

run().catch(console.dir);
