part of 'ticket_bloc.dart';

sealed class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

/// Create ticket
class CreateTicketEvent extends TicketEvent {
  final TicketEntity ticket;
  final File? image;
  
  const CreateTicketEvent({required this.ticket, this.image});
  @override
  List<Object> get props => [ticket.id];
}

/// Load tickets
class LoadUserTicketsEvent extends TicketEvent {
  final String userId;
  const LoadUserTicketsEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}

/// Load assigned tickets
class LoadAssignedTicketsEvent extends TicketEvent {
  final String userId;
  const LoadAssignedTicketsEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}

/// Update ticket
class UpdateTicketStatusEvent extends TicketEvent {
  final String ticketId;
  final TicketStatus oldStatus;
  final TicketStatus newStatus;
  final String changedBy;
  const UpdateTicketStatusEvent({
    required this.ticketId,
    required this.oldStatus,
    required this.newStatus,
    required this.changedBy,
  });
  @override
  List<Object> get props => [ticketId, oldStatus, newStatus, changedBy];
}
