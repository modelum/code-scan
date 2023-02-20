import mongoose from "mongoose";

const RepositorySchema = new mongoose.Schema(
  {
    _id: { type: String, required: true },
    developers: { type: [String], required: true, ref: 'Developer'},
    num_forks: { type: Number, required: true },
    num_stars: { type: Number, required: true },
    tags: { type: [String] },
    title: { type: String, required: true },
    url: { type: String, required: true },
  },
  {
    versionKey: false,
    collection: 'Repository'
  }
);

export default mongoose.model("Repository", RepositorySchema);
