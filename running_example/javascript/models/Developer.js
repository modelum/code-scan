import mongoose from "mongoose";

var DeveloperInfo = require('./DeveloperInfo')

const DeveloperSchema = new mongoose.Schema(
  {
    _id:           { type: String, required: true },
    email:         { type: String, required: true },
    permissions:   { type: String, required: true },
    dev_info:      { type: DeveloperInfo, required: true },
    is_active:     { type: Boolean },
    suspended_acc: { type: String },
  },
  {
    versionKey: false,
    collection: 'Developer'
  }
);

export default mongoose.model("Developer", DeveloperSchema);
