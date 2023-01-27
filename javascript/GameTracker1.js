import { MongoClient } from "mongodb";

// Replace the uri string with your MongoDB deployment's connection string.
const uri = "<connection string uri>";
const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const GameTracker = client.db("GameTracker");

    // ADD ENTITY Guild: { +id: Identifier, code: String, name: String, num_players: Number }
    GameTracker.createCollection("Guild")
    GameTracker.Guild.updateMany({}, [{$addFields: { "id": ObjectId(), "code": "", "name": "", "num_players": NumberInt(0)}}], {upsert: true})

    // RENAME ENTITY Player TO GamePlayer
    GameTracker.Player.renameCollection("GamePlayer")

    // ADAPT ENTITY GamePlayer::2 TO 1
    GameTracker.GamePlayer.updateMany({
      "experience": {$exists: false}, "hours_played": {$exists: false}, "ach_earned": {$exists: false}, "score": {$exists: false}}, [
      {$addFields: {"experience": 0.0, "hours_played": 0.0, "ach_earned": [{"achievement": ObjectId(), "of_the_day": false, "completed_at": "", "points": NumberInt(0)}], "score": NumberInt(0)}}
    ])

    // DELETE Achievement::is_active
    GameTracker.Achievement.updateMany({}, {$unset: { "is_active": 1 }})

    // RENAME Ach_Summary::completed_at TO is_completed
    GameTracker.Ach_Summary.updateMany({}, {$rename: {"completed_at": "is_completed"}})

    GameTracker.GamePlayer.bulkWrite([
      // NEST GamePlayer::reputation, suspended TO Player_Data
      {updateMany: {filter: {}, update: {$rename: { "reputation": "Player_Data.reputation", "suspended": "Player_Data.suspended" }}}},
      // UNNEST GamePlayer::user_data.email
      {updateMany: {filter: {}, update: {$rename: { "user_data.email": "email"}}}}
    ])

    GameTracker.Player_Data.bulkWrite([
      // ADD ATTR Player_Data::surname: String
      {updateMany: {filter: {}, update: [{$addFields: { "surname": ""}}], "upsert": true}},
      // ADD ATTR Player_Data::homepage: String
      {updateMany: {filter: {}, update: [{$addFields: { "homepage": ""}}], "upsert": true}}
    ])

    // CAST ATTR    *::score, points TO Double
    GameTracker.getCollectionNames().forEach(function(collName)
    {
      GameTracker[collName].updateMany({}, [{$set: { "score" : { $convert: { input: "$score", to: 1 }}, "points" : { $convert: { input: "$points", to: 1 }} }}])
    })

    // CAST ATTR Ach_Summary::is_completed TO Boolean
    GameTracker.Ach_Summary.updateMany({}, [{$set: { "is_completed" : { $convert: { input: "$is_completed", to: 8 }} }}])

    GameTracker.Guild.bulkWrite([
    // PROMOTE ATTR Guild::code
    // Operation not supported.,
    // ADD AGGR Guild::realm: { num_guilds: Number, max_guilds: Number, num_players: Number, max_players: Number, type: String }& AS Realm
      {updateMany: {filter: {}, update: [{$addFields: { "realm": {"num_guilds": NumberInt(0), "max_guilds": NumberInt(0), "num_players": NumberInt(0), "max_players": NumberInt(0), "type": ""}}}], upsert: true}}
    ])

    GameTracker.Player_Data.bulkWrite([
      // ADD AGGR Player_Data::address: { country: String, city: String }& AS Address
      {updateMany: {filter: {}, update: [{$addFields: { "address": {"country": "", "city": ""}}}], upsert: true}},
      // MULT AGGR Player_Data::address TO +
      {updateMany: {filter: {}, update: [{$set: { "address": [ "$address" ] }}]}}
    ])

    // MORPH AGGR GamePlayer::user_data TO user_private_data
    GameTracker.GamePlayer.find().forEach(function(sDoc) {
        if (!sDoc.user_data.hasOwnProperty('_id'))
          sDoc.user_data._id = ObjectId();

        GameTracker.User_data.insert(sDoc.user_data);
        sDoc.user_private_data = sDoc.user_data._id;
        sDoc.user_data = null;
        GameTracker.GamePlayer.save(sDoc);
    });

  } finally {
    await client.close();
  }
}

run().catch(console.dir);
