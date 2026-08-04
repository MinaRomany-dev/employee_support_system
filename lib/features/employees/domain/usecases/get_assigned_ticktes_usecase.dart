import 'package:dartz/dartz.dart';
import 'package:employee_support_system/core/error/failure.dart';
import 'package:employee_support_system/features/employees/domain/entity/ticket_entity.dart';
import 'package:employee_support_system/features/employees/domain/repo/tickets_repo.dart';
import 'package:injectable/injectable.dart';
@singleton
class GetAssignedTicktesUsecase {
  final TicketRepository repository;
  GetAssignedTicktesUsecase(this.repository);

  Future<Either<AppFailure, List<TicketEntity>>> call(String userId) {
    return repository.getAssignedTickets(userId);
  }
}
