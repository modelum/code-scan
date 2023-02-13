import mongoose from "mongoose";

const TicketSchema = new mongoose.Schema(
  {
    _id: { type: String, required: true },
    created_time: { type: Date, required: true },
    developer_id: { type: String, required: true, ref: 'Developer'},
    last_activity_date: { type: Date, required: true },
    message: { type: String, required: true },
    repository_id: { type: String, required: true, ref: 'Repository'},
  },
  {
    versionKey: false,
    collection: 'Ticket'
  }
);

export default mongoose.model("Ticket", TicketSchema);
