import { MongoClient } from "mongodb";

// Replace the uri string with your MongoDB deployment's connection string.
const uri = "<connection string uri>";
const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const database = client.db("running_example");
    const developers = database.collection("Developer");

    // create a filter for a movie to update
    const filter = { email: "Random Harvest" };
    // this option instructs the method to create a document if no documents match the filter
    const options = { upsert: true };
    // create a document that sets the plot of the movie
    const updateDoc = {
      $set: {
        plot: `A harvest of random numbers, such as: ${Math.random()}`
      },
    };

    const result = await developers.updateOne(filter, updateDoc, options);
    console.log(`${result.matchedCount} document(s) matched the filter, updated ${result.modifiedCount} document(s)`,);

  } finally {
    await client.close();
  }
}

run().catch(console.dir);
