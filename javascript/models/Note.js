import mongoose from "mongoose";

const NoteSchema = new mongoose.Schema(
  {
    title: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
    user: {
      type: String,
      required: true,
    },
  },
  {
    timestamps: true,
  }
);

export default mongoose.model("Note", NoteSchema);

const NoteSchema2 = new mongoose.Schema(
  {
    newAttr: {type: String, required: true},
    title: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
    user: {
      type: String,
      required: true,
    },
  },
  {
    timestamps: true,
  }
);

export default mongoose.model("Note", NoteSchema2);

export default mongoose.model("Note", new mongoose.Schema(
  {
    newAttr: {type: String, required: true},
    title: { type: String, required: true, },
    description: { type: String, required: true, },
    user: { type: String, required: true, },
  },
  { timestamps: true, }
));

export default mongoose.model("Note", new mongoose.Schema(
  {
    description: { type: String, required: true, },
    user: { type: String, required: true, },
  },
  { timestamps: true, }
));
