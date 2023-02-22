import { MongoClient } from "mongodb";

const uri = "<connection string uri>";
const client = new MongoClient(uri);

async function run() {
 try {
  await client.connect();
  database = client.db("software_dev_sample");

  // Try to access Developer.permissions
  developers = database.collection("Developer");
  result1 = await developers.findOne(
    {_id: "13"},
    {projection: {"permissions": 1}});

  // Query the Ticket entity type
  collection_name = "Ticket";
  tickets= database.collection(collection_name);
  query = { message: { $regex: "error" } };
  result2 = await tickets.deleteMany(query);
  console.log(result2.deletedCount);
 } finally {
  await client.close();
 }
}

run().catch(console.dir);
