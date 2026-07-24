import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/failure.dart';
import 'package:employee_support_system/features/comment/domain/entities/comment_entity.dart';

abstract class CommentRepository {
  Future<Either<AppFailure, void>> addComment(CommentEntity comment);
  Stream<Either<AppFailure, List<CommentEntity>>> getComments(String ticketId);
}