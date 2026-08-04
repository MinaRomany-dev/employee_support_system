import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:employee_support_system/features/employees/data/models/ticket_model.dart';
import 'package:employee_support_system/features/employees/domain/entity/ticket_entity.dart';
import 'package:employee_support_system/features/employees/domain/usecases/create_ticket_usecase.dart';
import 'package:employee_support_system/features/employees/domain/usecases/get_assigned_ticktes_usecase.dart';
import 'package:employee_support_system/features/employees/domain/usecases/get_user_tickets_usecase.dart';
import 'package:employee_support_system/features/employees/domain/usecases/update_ticket_status_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

@injectable
class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final UpdateTicketStatusUsecase updateTicketStatusUseCase;
  final CreateTicketUseCase createTicketUseCase;
  final GetUserTicketsUsecase getUserTicketsUseCase;
  final GetAssignedTicktesUsecase getAssignedTicketsUseCase;
  TicketBloc(
    this.updateTicketStatusUseCase,
    this.createTicketUseCase,
    this.getUserTicketsUseCase,
    this.getAssignedTicketsUseCase,
  ) : super(TicketInitial()) {
    on<CreateTicketEvent>((event, emit) async {
      emit(TicketCreationLoading());
      final resutlt = await createTicketUseCase(event.ticket, event.image);
      resutlt.fold(
        (l) => emit(TicketCreationFailure(l.message)),
        (r) => emit(TicketCreatedSuccessfully()),
      );
    });
    on<LoadUserTicketsEvent>((event, emit) async {
      emit(TicketLoading());
      final result = await getUserTicketsUseCase(event.userId);
      result.fold(
        (l) => emit(TicketLoadingFailure(l.message)),
        (r) => emit(TicketLoaded(r)),
      );
    });
    on<LoadAssignedTicketsEvent>((event, emit) async {
      emit(AssignedTicketsLoading());
      final result = await getAssignedTicketsUseCase(event.userId);
      result.fold(
        (l) => emit(AssignedTicketsFailure(l.message)),
        (r) => emit(AssignedTicketsLoaded(r)),
      );
    });

    on<UpdateTicketStatusEvent>((event, emit) async {
      final currentState = state;
      if (currentState is! AssignedTicketsLoaded) return;

      final result = await updateTicketStatusUseCase(
        ticketId: event.ticketId,
        oldStatus: event.oldStatus,
        newStatus: event.newStatus,
        changedBy: event.changedBy,
      );

      result.fold((l) => emit(UpdateTicketStatusFailure(l.message)), (r) {
        final updatelist = currentState.tickets.map((e) {
          if (e.id == event.ticketId) {
            return e.copyWith(status: event.newStatus);
          }
          return e;
        }).toList();
        emit(AssignedTicketsLoaded(updatelist));
      });
    });
  }
}
