import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/exception.dart';
import 'package:employee_support_system/core/error/failure.dart';
import 'package:employee_support_system/core/error/failure_handler.dart';
import 'package:employee_support_system/features/comment/data/datasource/comment_remote_datasource.dart';
import 'package:employee_support_system/features/comment/data/mappars/comment_mapper.dart';
import 'package:employee_support_system/features/comment/domain/entities/comment_entity.dart';
import 'package:employee_support_system/features/comment/domain/repo/comment_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CommentRepository)
class CommentRepositoryImpl implements CommentRepository {
  final Commentremotedatasource datasource;
  const CommentRepositoryImpl(this.datasource);

  @override
  Future<Either<AppFailure, void>> addComment(CommentEntity comment) async {
    try {
      await datasource.addComment(comment.toModel());
      return const Right(null);
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Stream<Either<AppFailure, List<CommentEntity>>> getComments(String ticketId) {
    return datasource
        .getComment(ticketId)
        .map(
          (models) => Right<AppFailure, List<CommentEntity>>(
            models.map((m) => m.toEntity()).toList(),
          ),
        )
        .handleError((e) => Left(mapExceptionToFailure(e as AppException)));
  }
}
