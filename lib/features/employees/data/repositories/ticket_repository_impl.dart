import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/exception.dart';
import 'package:employee_support_system/core/error/failure.dart';
import 'package:employee_support_system/core/error/failure_handler.dart';
import 'package:employee_support_system/features/employees/data/datasource/ticket_remote_datasource.dart';
import 'package:employee_support_system/features/employees/data/mappers/ticket_mappers.dart';
import 'package:employee_support_system/features/employees/data/models/ticket_model.dart';
import 'package:employee_support_system/features/employees/domain/entity/ticket_entity.dart';
import 'package:employee_support_system/features/employees/domain/repo/tickets_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TicketRepository)
class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDatasource datasource;
  const TicketRepositoryImpl(this.datasource);

  @override
  Future<Either<AppFailure, void>> createTicket(
    TicketEntity ticket,
    File? image,
  ) async {
    try {
      await datasource.createTicket(ticket.toModel(), image);
      return Right(null);
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AppFailure, List<TicketEntity>>> getUserTickets(
    String userId,
  ) async {
    try {
      final list = await datasource.getuserTickets(userId);
      return Right(list.map((models) => models.toEntity()).toList());
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AppFailure, List<TicketEntity>>> getAssignedTickets(
    String userId,
  ) async {
    try {
      final list = await datasource.getAssignedTickets(userId);
      return Right(list.map((models) => models.toEntity()).toList());
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateTicketStatus({
    required String ticketId,
    required TicketStatus oldStatus,
    required TicketStatus newStatus,
    required String changedBy,
  }) async {
    try {
      await datasource.updateTicketStatus(
        ticketId: ticketId,
        oldStatus: oldStatus,
        newStatus: newStatus,
        changedBy: changedBy,
      );
      return Right(null);
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}


  // @override
  // Future<Either<Failure, List<TicketEntity>>> getAllTickets() async {
  //   try {
  //     final models = await datasource.getAllTickets();
  //     return Right(models.map((m) => m.toEntity()).toList());
  //   } on AppException catch (e) {
  //     return Left(Failure(e.message));
  //   }
  // }


