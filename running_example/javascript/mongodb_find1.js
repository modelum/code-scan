import { MongoClient } from "mongodb";

// Replace the uri string with your MongoDB deployment's connection string.
const uri = "<connection string uri>";
const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const database = client.db("running_example");
    const developers = database.collection("Developer");
    // Query for a movie that has the title 'The Room'
    const query = { email: "room@mail.com" };
    const options = {
      // sort matched documents in descending order by rating
      sort: { "permissions": -1 },
      // Include only the `title` and `imdb` fields in the returned document
      projection: { _id: 0, email: 1, permissions: 1 },
    };
    const developers = await developers.findOne(query, options);

    // since this method returns the matched document, not a cursor, print it directly
    console.log(developers);

  } finally {
    await client.close();
  }
}
run().catch(console.dir);
