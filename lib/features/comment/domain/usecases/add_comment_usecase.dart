import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/failure.dart';
import 'package:employee_support_system/features/comment/domain/entities/comment_entity.dart';
import 'package:employee_support_system/features/comment/domain/repo/comment_repo.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class AddCommentUsecase {
  final CommentRepository repository;
  const AddCommentUsecase(this.repository);

  Future<Either<AppFailure, void>> call(CommentEntity comment) {
    return repository.addComment(comment);
  }
}
