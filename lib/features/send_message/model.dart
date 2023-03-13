enum MessageType {
  text,
  video,
  record,
}

class Message {
  int id;
  MessageType type;
  String body;
  String createdAt;

  Message(this.id, this.type, this.body, this.createdAt);
}
