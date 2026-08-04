import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/failure.dart';
import 'package:employee_support_system/features/employees/data/models/ticket_model.dart';
import 'package:employee_support_system/features/employees/domain/repo/tickets_repo.dart';
import 'package:injectable/injectable.dart';

@singleton
class UpdateTicketStatusUsecase {
  final TicketRepository repository;

  UpdateTicketStatusUsecase(this.repository);

  Future<Either<AppFailure, void>> call({
    required String ticketId,
    required TicketStatus oldStatus,
    required TicketStatus newStatus,
    required String changedBy,
  }) {
    return repository.updateTicketStatus(
      ticketId: ticketId,
      oldStatus: oldStatus,
      newStatus: newStatus,
      changedBy: changedBy,
    );
  }
}
