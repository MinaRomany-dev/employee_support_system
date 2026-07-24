class CommentEntity {
  final String id;
  final String ticketId;
  final String? senderName;
  final String? senderRole;
  final String content;
  final String userId;
  final DateTime createdAt;

  const CommentEntity({
    required this.senderName,
    required this.senderRole,
    required this.id,
    required this.ticketId,
    required this.content,
    required this.userId,
    required this.createdAt,
  });
}