class CommentModel {
  final String id;
  final String? senderName;
  final String? senderRole;
  //final String senderImage;
  final String ticketId;
  final String content;
  final String userId;
  final DateTime createdAt;

  CommentModel({
    required this.senderRole,
    required this.senderName,
    // required this.senderImage,
    required this.id,
    required this.content,
    required this.userId,
    required this.ticketId,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      senderName: json['sender']?["name"],
      senderRole: json['sender']?["role"],

      //   senderImage: json['sender']?["profile_image_url"],
      id: json['id'],
      content: json['content'],
      userId: json['user_id'],
      ticketId: json['ticket_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'content': content, 'user_id': userId, 'ticket_id': ticketId};
  }
}
