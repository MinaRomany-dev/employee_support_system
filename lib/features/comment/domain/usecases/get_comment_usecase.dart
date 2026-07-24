import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/failure.dart';
import 'package:employee_support_system/features/comment/domain/entities/comment_entity.dart';
import 'package:employee_support_system/features/comment/domain/repo/comment_repo.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class GetCommentUsecase {
   final CommentRepository repository;
  const GetCommentUsecase(this.repository);

  Stream<Either<AppFailure, List<CommentEntity>>> call(String ticketId) {
    return repository.getComments(ticketId);
  }
}