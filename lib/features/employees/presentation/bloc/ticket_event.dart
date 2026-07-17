part of 'ticket_bloc.dart';

sealed class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

class CreateTicketEvent extends TicketEvent {
  final TicketEntity ticket;
  final File? image;
  const CreateTicketEvent({required this.ticket, this.image});
  @override
  List<Object> get props => [ticket.id];
}

class LoadUserTicketsEvent extends TicketEvent {
  final String userId;
  const LoadUserTicketsEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}
