import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/failure.dart';
import 'package:employee_support_system/features/comment/domain/entities/comment_entity.dart';
import 'package:employee_support_system/features/comment/domain/usecases/add_comment_usecase.dart';
import 'package:employee_support_system/features/comment/domain/usecases/get_comment_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'comment_event.dart';
part 'comment_state.dart';

@injectable
class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AddCommentUsecase addCommentUseCase;
  final GetCommentUsecase getCommentsUseCase;

  CommentBloc(this.addCommentUseCase, this.getCommentsUseCase)
    : super(CommentInitial()) {
    // load with real-time
    on<LoadCommentsEvent>((event, emit) async {
      emit(CommentsLoading());
      await emit.forEach<Either<AppFailure, List<CommentEntity>>>(
        getCommentsUseCase(event.ticketId),
        onData: (result) => result.fold(
          (failure) => CommentsError(failure.message),
          (comments) => CommentsLoaded(comments: comments, isSending: false),
        ),
        onError: (e, _) => CommentsError(e.toString()),
      );
    });

    on<AddCommentEvent>((event, emit) async {
      final result = await addCommentUseCase(
        CommentEntity(
          senderName: '',
          senderRole: '',
          id: '',
          ticketId: event.ticketId,
          content: event.content,
          userId: event.userId,
          createdAt: DateTime.now(),
        ),
      );
      result.fold((failure) => emit(CommentAddError(failure.message)), (_) {});
    });
  }
}
