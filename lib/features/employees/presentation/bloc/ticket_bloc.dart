import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:employee_support_system/features/employees/domain/entity/ticket_entity.dart';
import 'package:employee_support_system/features/employees/domain/usecases/create_ticket_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

@injectable
class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final CreateTicketUseCase createTicketUseCase;

  TicketBloc(this.createTicketUseCase) : super(TicketInitial()) {
    on<CreateTicketEvent>((event, emit) async {
      emit(TicketLoading());
      final resutlt = await createTicketUseCase(event.ticket, event.image);
      resutlt.fold(
        (l) => emit(TicketError(l.message)),
        (r) => emit(TicketCreatedSuccessfully()),
      );
    });
  }
}
