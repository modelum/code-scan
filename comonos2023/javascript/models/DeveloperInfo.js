import mongoose from "mongoose";

const DeveloperInfoSchema = new mongoose.Schema(
  {
    about_me: { type: String },
    name:     { type: String, required: true },
    team:     { type: String, required: true },
  }, { versionKey: false, _id: false }
);

export default mongoose.model("DeveloperInfo", DeveloperInfoSchema);
