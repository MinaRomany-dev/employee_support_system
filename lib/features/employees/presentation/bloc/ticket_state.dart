part of 'ticket_bloc.dart';

sealed class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

final class TicketInitial extends TicketState {}

final class TicketCreationLoading extends TicketState {}

final class TicketCreationFailure extends TicketState {
  final String message;

  const TicketCreationFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class TicketCreatedSuccessfully extends TicketState {
  final String message = "Ticket created successfully";

  const TicketCreatedSuccessfully();
}

final class TicketLoaded extends TicketState {
  final List<TicketEntity> tickets;

  const TicketLoaded(this.tickets);
  @override
  List<Object> get props => [tickets];
}

final class TicketLoading extends TicketState {}

final class TicketLoadingFailure extends TicketState {
  final String message;

  const TicketLoadingFailure(this.message);
}

final class AssignedTicketsLoaded extends TicketState {
  final List<TicketEntity> tickets;

  const AssignedTicketsLoaded(this.tickets);
  @override
  List<Object> get props => [tickets];
}

final class AssignedTicketsLoading extends TicketState {}

final class AssignedTicketsFailure extends TicketState {
  final String message;

  const AssignedTicketsFailure(this.message);
  @override
  List<Object> get props => [message];
}

final class UpdateTicketStatusFailure extends TicketState {
  final String message;

  const UpdateTicketStatusFailure(this.message);
  @override
  List<Object> get props => [message];
}
