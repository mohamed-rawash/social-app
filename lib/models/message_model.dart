class MessageModel {
  String? senderId;
  String? receiverId;
  String? message;
  String? time;

  MessageModel({required this.senderId, required this.receiverId, required this.message, required this.time});

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    message = json['message'];
    time = json['time'];
  }
  toJson() {
    return {
      "sender_id": senderId,
      "receiver_id": receiverId,
      "message": message,
      "time": time
    };
  }
}