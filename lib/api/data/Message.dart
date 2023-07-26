class Message {
  String status;
  String message;

  Message({required this.status, required this.message});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        status: json['status'] as String, message: json['message'] as String);
  }
}
