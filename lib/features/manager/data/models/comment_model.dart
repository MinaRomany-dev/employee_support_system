class CommentModel {
  final String id;
  final String ticketId;
  final String content;
  final String userId;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.content,
    required this.userId,
    required this.ticketId,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
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

