part of 'ticket_bloc.dart';

sealed class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

final class TicketInitial extends TicketState {}

final class TicketLoading extends TicketState {}

final class TicketError extends TicketState {
  final String message;

  const TicketError(this.message);
}

final class TicketCreatedSuccessfully extends TicketState {
  final String message = "Ticket created successfully";

  const TicketCreatedSuccessfully();
}

final class TicketUpdated extends TicketState {}
