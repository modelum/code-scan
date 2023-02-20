import { MongoClient } from "mongodb";

// Replace the uri string with your MongoDB deployment's connection string.

const uri = "<connection string uri>";
const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const database = client.db("running_example");
    const repositories = database.collection("Repository");
    // query for movies that have a runtime less than 15 minutes
    const query = { num_forks: { $lt: 15 } };
    const options = {
      // sort returned documents in ascending order by title (A->Z)
      sort: { title: 1 },
      // Include only the `title` and `imdb` fields in each returned document
      projection: { _id: 0, title: 1, url: 1 },
    };
    const cursor = repositories.find(query, options);

    // print a message if no documents were found
    if ((await cursor.count()) === 0) {
      console.log("No documents found!");
    }
    // replace console.dir with your callback to access individual elements
    await cursor.forEach(console.dir);

  } finally {
    await client.close();
  }
}

run().catch(console.dir);
