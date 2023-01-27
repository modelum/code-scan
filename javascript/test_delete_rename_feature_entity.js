import { MongoClient } from "mongodb";

// Replace the uri string with your MongoDB deployment's connection string.
const uri = "<connection string uri>";
const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    dbName = "sample";
    const database = client.db(dbName);

    goodCollName = "movies"
    badCollName = "notMovies"
    goodCollection = database.collection(goodCollName)
    badCollection = database.collection(badCollName)

    const query = { title: "title1" };

    // Expressions to detect the correct collection
    database.movies.deleteOne(query);
    database["movies"].deleteOne(query);
    database.collection(goodCollName).deleteOne(query);
    goodCollection.deleteOne(query);

    // Erroneous collections
    database.notMovies.deleteOne(query);
    database["notMovies"].deleteOne(query);
    database.collection(badCollName).deleteOne(query);
    badCollection.deleteOne(query);

    // Expressions to detect the correct field
    const goodQuery1 = { title: "title2" };
    const goodQuery2 = { title: { $lt: 15 } };
    const badQuery = { notTitle: "notTitle1" };
    const options1 = { sort: { "imdb.rating": -1 }, projection: { _id: 0, imdb: 1 },};
    const options2 = { sort: { title: 1 },projection: { _id: 0, title: 1, imdb: 1 },};
    const options3 = { sort: { "title": 1 },projection: { "_id": 0, "title": 1, "imdb": 1 },};

    // FIND/FINDONE operations: Should be detected
    await goodCollection.findOne(goodQuery1, options1);
    await goodCollection.findOne(goodQuery2, options1);
    await goodCollection.findOne(badQuery, options2);
    await goodCollection.findOne(badQuery, options3);
    goodCollection.find(goodQuery1, options1);
    goodCollection.find(goodQuery2, options1);
    goodCollection.find(badQuery, options2);
    goodCollection.find(badQuery, options3);

    // SORT PROJECT COUNT COUNTDOCUMENT DELETEONE DELETEMANY operations: Should be detected
    await goodCollection.countDocuments(goodQuery1);
    goodCollection.countDocuments(goodQuery2);
    await goodCollection.sort(goodQuery1);
    goodCollection.sort(goodQuery2);
    await goodCollection.deleteOne(goodQuery1);
    goodCollection.deleteOne(goodQuery2);
    await goodCollection.deleteMany(goodQuery1);
    goodCollection.deleteMany(goodQuery2);

    // DISTINCT operation: Should be detected
    const fieldName = "title";
    goodCollection.distinct(fieldName, goodQuery1);
    goodCollection.distinct("title", goodQuery1);
    goodCollection.distinct("title", badQuery);

    // INSERT operations: Should be detected
    goodQueries = [goodQuery1, goodQuery2]
    badQueries = [badQuery, badQuery]
    goodCollection.insertOne(goodQuery1)
    goodCollection.insertOne({"title": "value"})
    goodCollection.insertMany([{"title": "value1"}, {"title": "value2"}])
    goodCollection.insertMany(goodQueries)
    goodCollection.insertMany([goodQuery1, goodQuery1])

    // UPDATE operations: Should be detected
    const goodUpdate = { $set: { title: `A harvest of random numbers, such as: ${Math.random()}` },};
    const badUpdate = { $set: { notTitle: `A harvest of random numbers, such as: ${Math.random()}` },};
    const updateOptions = { upsert: true };
    goodCollection.updateOne(goodQuery1, goodUpdate, updateOptions);
    goodCollection.updateOne(goodQuery1, goodUpdate);
    goodCollection.updateOne(badQuery1, goodUpdate, updateOptions);
    goodCollection.updateOne(badQuery1, goodUpdate);
    goodCollection.updateOne(goodQuery1, badUpdate, updateOptions);
    goodCollection.updateOne(goodQuery1, badUpdate);
    goodCollection.updateMany(goodQuery1, goodUpdate, updateOptions);
    goodCollection.updateMany(goodQuery1, goodUpdate);
    goodCollection.updateMany(badQuery1, goodUpdate, updateOptions);
    goodCollection.updateMany(badQuery1, goodUpdate);
    goodCollection.updateMany(goodQuery1, badUpdate, updateOptions);
    goodCollection.updateMany(goodQuery1, badUpdate);

    // BULKWRITE operations: Should be detected
    goodCollection.bulkWrite([
      {insertOne: {document: {location: {address: {street1: "3 Main St.",city: "Anchorage",state: "AK",zipcode: "99501",},},},},},
      {updateMany: {filter: { "title": "44011" },update: { $set: { is_in_ohio: true } },upsert: true,},},
      {deleteOne: { filter: { "location.address.street1": "221b Baker St" } },},
    ]);
    goodCollection.bulkWrite([
      {insertOne: {document: {location: {address: {street1: "3 Main St.",city: "Anchorage",state: "AK",zipcode: "99501",},},},},},
      {updateMany: {filter: goodQuery1,update: { $set: { is_in_ohio: true } },upsert: true,},},
      {deleteOne: { filter: { "location.address.street1": "221b Baker St" } },},
    ]);
    goodCollection.bulkWrite([
      {insertOne: {document: {location: {address: {street1: "3 Main St.",city: "Anchorage",state: "AK",zipcode: "99501",},},},},},
      {updateMany: {update: { $set: { title: true } },upsert: true,},},
      {deleteOne: { filter: { "location.address.street1": "221b Baker St" } },},
    ]);
    goodCollection.bulkWrite([
      {insertOne: {document: {location: {address: {street1: "3 Main St.",city: "Anchorage",state: "AK",zipcode: "99501",},},},},},
      {updateMany: {update: { $set: { "title": true } },upsert: true,},},
      {deleteOne: { filter: { "location.address.street1": "221b Baker St" } },},
    ]);
    goodCollection.bulkWrite([
      {insertOne: {document: goodQuery1,},},
      {updateMany: {filter: badQuery,update: { $set: { is_in_ohio: true } },upsert: true,},},
      {deleteOne: { filter: { "location.address.street1": "221b Baker St" } },},
    ]);
    goodCollection.bulkWrite([
      {insertOne: {document: {location: {address: {street1: "3 Main St.",city: "Anchorage",state: "AK",zipcode: "99501",},},},},},
      {updateMany: {filter: { "notTitle": "44011" },update: { $set: { is_in_ohio: true } },upsert: true,},},
      {deleteOne: { filter: { "title": "221b Baker St" } },},
    ]);

    // AGGREGATE operations
    goodCollection.aggregate([
                     { $match: { status: "A" } },
                     { $group: { _id: "$cust_id", total: { $sum: "$amount" } } },
                     { $sort: { "title": -1 } }
                   ])
    // TODO

    // FIND/FINDONE operations: Should NOT be detected
    await goodCollection.findOne(badQuery, options1);
    goodCollection.find(badQuery, options1);

    // SORT PROJECT COUNT COUNTDOCUMENT DELETEONE DELETEMANY operations: Should NOT be detected
    goodCollection.countDocuments(badQuery);
    goodCollection.sort(badQuery);
    goodCollection.deleteOne(badQuery);
    goodCollection.deleteMany(badQuery);

    // DISTINCT operation: Should NOT be detected
    const notFieldName = "notTitle";
    goodCollection.distinct(notFieldName, badQuery);
    goodCollection.distinct("NotTitle", badQuery);

    // INSERT operations: Should NOT be detected
    goodCollection.insertOne(badQuery)
    goodCollection.insertOne({"notTitle": "yodawg"})
    goodCollection.insertMany([badQuery, badQuery])
    goodCollection.insertMany([{"notTitle": "yodawg1"}, {"notTitle": "yodawg2"}])
    goodCollection.insertMany(badQueries)

    // UPDATE operations: Should NOT be detected
    goodCollection.updateOne(badQuery1, badUpdate, updateOptions);
    goodCollection.updateOne(badQuery1, badUpdate);
    goodCollection.updateMany(badQuery1, badUpdate, updateOptions);
    goodCollection.updateMany(badQuery1, badUpdate);

    // BULKWRITE operations: Should NOT be detected
    goodCollection.bulkWrite([
      {insertOne: {document: {location: {address: {street1: "3 Main St.",city: "Anchorage",state: "AK",zipcode: "99501",},},},},},
      {updateMany: {filter: { "notTitle": "44011" },update: { $set: { is_in_ohio: true } },upsert: true,},},
      {deleteOne: { filter: { "location.address.street1": "221b Baker St" } },},
    ]);
    goodCollection.bulkWrite([
      {insertOne: {document: {location: {address: {street1: "3 Main St.",city: "Anchorage",state: "AK",zipcode: "99501",},},},},},
      {updateMany: {filter: badQuery,update: { $set: { is_in_ohio: true } },upsert: true,},},
      {deleteOne: { filter: { "location.address.street1": "221b Baker St" } },},
    ]);
    goodCollection.bulkWrite([
      {insertOne: {document: badQuery,},},
      {updateMany: {filter: badQuery,update: { $set: { is_in_ohio: true } },upsert: true,},},
      {deleteOne: { filter: { "location.address.street1": "221b Baker St" } },},
    ]);
    goodCollection.bulkWrite([
      {insertOne: {document: {location: {address: {street1: "3 Main St.",city: "Anchorage",state: "AK",zipcode: "99501",},},},},},
      {updateMany: {filter: { "notTitle": "44011" },update: { $set: { is_in_ohio: true } },upsert: true,},},
      {deleteOne: { filter: { "notTitle": "221b Baker St" } },},
    ]);

  } finally {
    await client.close();
  }
}

run().catch(console.dir);
