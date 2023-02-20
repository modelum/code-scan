SoftwareDev = db.getSiblingDB("SoftwareDev")


// DELETE Developer::permissions

SoftwareDev.Developer.updateMany({}, {$unset: { "permissions": 1 }})

SoftwareDev.getCollectionNames().forEach(function(collName)
{
  SoftwareDev[collName].bulkWrite([
// RENAME *::num_forks TO rank_forks
  {updateMany: {filter: {}, update: {$rename: {"num_forks": "rank_forks" }}}},
// RENAME *::num_stars TO rank_stars

  {updateMany: {filter: {}, update: {$rename: {"num_stars": "rank_stars" }}}}
  ])
})

// COPY Ticket::last_activity_date TO Repository::last_ticket WHERE Ticket.repository_id = Repository._id

SoftwareDev.Ticket.createIndex({Ticket.repository_id: 1}, {name: "TEMP_INDEX_C1"})
SoftwareDev.Repository.createIndex({Repository._id: 1}, {name: "TEMP_INDEX_C2"})

SoftwareDev.Ticket.find().forEach( function(sDoc) { SoftwareDev.Repository.updateMany({ "_id": sDoc.repository_id }, { $set: { "last_ticket": sDoc.last_activity_date} }); })

// ADD ATTR Repository::subscribers: Number

SoftwareDev.Repository.updateMany({}, [{$addFields: { "subscribers": NumberInt(0)}}], {upsert: true})

SoftwareDev.Developer.bulkWrite([
// ADD AGGR Developer::dev_location: { city: String, country: String }& AS DeveloperLocation

  {updateMany: {filter: {}, update: [{$addFields: { "dev_location": {"city": "", "country": ""}}}], upsert: true}},
// CAST ATTR Developer::suspended_acc TO Boolean

  {updateMany: {filter: {}, update: [{$set: { "suspended_acc": { $convert: { input: "$suspended_acc", to: 8 }}  }}]}}
])

// RENAME ENTITY Ticket TO Active_Ticket

SoftwareDev.Ticket.renameCollection("Active_Ticket")

// ADD ENTITY Archived_Ticket: { +_id: String, archived_date: Timestamp, message: String }
SoftwareDev.createCollection("Archived_Ticket")
SoftwareDev.Archived_Ticket.updateMany({}, [{$addFields: { "_id": "", "archived_date": "", "message": ""}}], {upsert: true})

