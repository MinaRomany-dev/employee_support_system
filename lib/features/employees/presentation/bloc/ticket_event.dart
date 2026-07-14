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
