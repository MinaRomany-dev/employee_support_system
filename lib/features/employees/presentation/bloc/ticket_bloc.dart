import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:employee_support_system/features/employees/domain/entity/ticket_entity.dart';
import 'package:employee_support_system/features/employees/domain/usecases/create_ticket_usecase.dart';
import 'package:employee_support_system/features/employees/domain/usecases/get_user_tickets_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

@injectable
class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final CreateTicketUseCase createTicketUseCase;
  final GetUserTicketsUsecase getUserTicketsUseCase;

  TicketBloc(this.createTicketUseCase, this.getUserTicketsUseCase)
    : super(TicketInitial()) {
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
        (l) => emit(TicketLoadingError(l.message)),
        (r) => emit(TicketLoaded(r)),
      );
    });
  }
}
