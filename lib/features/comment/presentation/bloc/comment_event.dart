part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class LoadCommentsEvent extends CommentEvent {
  final String ticketId;
  const LoadCommentsEvent(this.ticketId);

  @override
  List<Object> get props => [ticketId];
}

class AddCommentEvent extends CommentEvent {
  final String ticketId;
  final String content;
  final String userId;

  const AddCommentEvent({
    required this.ticketId,
    required this.content,
    required this.userId,
  });

  @override
  List<Object> get props => [ticketId, content, userId];
}
