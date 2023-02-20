import { MongoClient } from "mongodb";

// Replace the uri string with your MongoDB deployment's connection string.

const uri = "<connection string uri>";
const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const database = client.db("running_example");
    const repositories = database.collection("Repository");

    // create a filter to update all movies with a 'G' rating
    const filter = { num_stars: "2" };
    // increment every document matching the filter with 2 more comments
    const updateDoc = {
      $set: {
        random_review: `After viewing I am ${
          100 * Math.random()
        }% more satisfied with life.`,
      },
    };

    const result = await repositories.updateMany(filter, updateDoc);
    console.log(`Updated ${result.modifiedCount} documents`);
  } finally {
    await client.close();
  }
}

run().catch(console.dir);
