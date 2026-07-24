part of 'comment_bloc.dart';

sealed class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

final class CommentInitial extends CommentState {}

final class CommentsLoading extends CommentState {}

final class CommentsLoaded extends CommentState {
  final List<CommentEntity> comments;
  final bool isSending;

  const CommentsLoaded({
    required this.comments,
    this.isSending = false,
  });

  CommentsLoaded copyWith({
    List<CommentEntity>? comments,
    bool? isSending,
  }) {
    return CommentsLoaded(
      comments: comments ?? this.comments,
      isSending: isSending ?? this.isSending,
    );
  }

  @override
  List<Object> get props => [comments, isSending];
}


final class CommentsError extends CommentState {
  final String message;
  const CommentsError(this.message);

  @override
  List<Object> get props => [message];
}

final class CommentAdding extends CommentState {}

final class CommentAdded extends CommentState {}

final class CommentAddError extends CommentState {
  final String message;
  const CommentAddError(this.message);

  @override
  List<Object> get props => [message];
}
