import { MongoClient } from "mongodb";

// Replace the uri string with your MongoDB deployment's connection string.

const uri = "<connection string uri>";

const client = new MongoClient(uri);

async function run() {
  try {

    await client.connect();

    const database = client.db("running_example");
    const tickets = database.collection("Ticket");

    const result = await tickets.bulkWrite([
      {insertOne: {document: {email: "mail@domain.com"},},},
      {insertOne: {document: {permissions: "RW"},},},
      {updateMany: {filter: { "location.address.zipcode": "44011" },update: { $set: { is_in_ohio: true } },upsert: true,},},
      {deleteOne: { filter: { "location.address.street1": "221b Baker St" } },},
    ]);

    console.log(result);

  } finally {
    await client.close();
  }
}

run().catch(console.dir);
