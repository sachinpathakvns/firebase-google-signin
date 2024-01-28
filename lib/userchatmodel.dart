class UserChatModel {
  String conversationId;
  String from;
  String to;
  String message;
  dynamic timestamp;
  bool isread;

  UserChatModel({
    required this.conversationId,
    required this.from,
    required this.to,
    required this.message,
    required this.timestamp,
    required this.isread,
  });

  factory UserChatModel.fromJson(Map<String, dynamic> json) => UserChatModel(
    conversationId: json["conversationId"],
    from: json["from"],
    to: json["to"],
    message: json["message"],
    timestamp: json["timestamp"],
    isread: json["isread"],
  );

  Map<String, dynamic> toJson() => {
    "conversationId": conversationId,
    "from": from,
    "to": to,
    "message": message,
    "timestamp": timestamp,
    "isread": isread,
  };
}
