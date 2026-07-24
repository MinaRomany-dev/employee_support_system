import 'package:employee_support_system/features/comment/data/models/comment_model.dart';
import 'package:employee_support_system/features/comment/domain/entities/comment_entity.dart';

extension CommentMapper on CommentModel {
  CommentEntity toEntity() => CommentEntity(
    senderName: senderName,
    senderRole: senderRole,
    id: id,
    ticketId: ticketId,
    content: content,
    userId: userId,
    createdAt: createdAt,
  );
}

extension CommentEntityMapper on CommentEntity {
  CommentModel toModel() => CommentModel(
    senderName: senderName,
    senderRole: senderRole,
    id: id,
    ticketId: ticketId,
    content: content,
    userId: userId,
    createdAt: createdAt,
  );
}
