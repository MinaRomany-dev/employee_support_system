import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/failure.dart';
import 'package:employee_support_system/features/employees/domain/entity/ticket_entity.dart';
import 'package:employee_support_system/features/employees/domain/repo/tickets_repo.dart';
import 'package:injectable/injectable.dart';

@singleton
class CreateTicketUseCase {
  final TicketRepository repository;
  const CreateTicketUseCase(this.repository);

  Future<Either<AppFailure, void>> call(TicketEntity ticket, File? image) {
    return repository.createTicket(ticket, image);
  }
}
