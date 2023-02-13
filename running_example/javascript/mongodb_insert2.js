import { MongoClient } from "mongodb";

// Replace the uri string with your MongoDB deployment's connection string.

const uri = "<connection string uri>";
const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const database = client.db("running_example");
    const repositories = database.collection("Repository");

    // create an array of documents to insert
    const docs = [
      { title: "cake", num_forks: 1 },
      { title: "lettuce", num_forks: 1 },
      { title: "donut", num_stars: 3 }
    ];

    // this option prevents additional documents from being inserted if one fails
    const options = { ordered: true };
    const result = await repositories.insertMany(docs, options);
    console.log(`${result.insertedCount} documents were inserted`);

  } finally {
    await client.close();
  }
}

run().catch(console.dir);
