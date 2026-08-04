import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/failure.dart';
import 'package:employee_support_system/features/employees/data/models/ticket_model.dart';
import 'package:employee_support_system/features/employees/domain/entity/ticket_entity.dart';

abstract class TicketRepository {
  Future<Either<AppFailure, void>> createTicket(
    TicketEntity ticket,
    File? image,
  );
  Future<Either<AppFailure, List<TicketEntity>>> getUserTickets(String userId);

  Future<Either<AppFailure, List<TicketEntity>>> getAssignedTickets(
    String userId,
  );
  Future<Either<AppFailure, void>> updateTicketStatus({
    required String ticketId,
    required TicketStatus oldStatus,
    required TicketStatus newStatus,
    required String changedBy,
  });
}
