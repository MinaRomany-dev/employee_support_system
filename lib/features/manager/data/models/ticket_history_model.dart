class TicketHistoryModel {
  final String id;
  final String ticketId;
  final String? oldStatus;
  final String newStatus;
  final String changedBy;
  final DateTime? changedAt;

  TicketHistoryModel({
    required this.id,
    required this.ticketId,
    this.oldStatus,
    required this.newStatus,
    required this.changedBy,
    this.changedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'ticket_id': ticketId,
      'old_status': oldStatus,
      'new_status': newStatus,
      'changed_by': changedBy,
    };
  }

  factory TicketHistoryModel.fromJson(Map<String, dynamic> json) {
    return TicketHistoryModel(
      id: json['id'],
      ticketId: json['ticket_id'],
      oldStatus: json['old_status'],
      newStatus: json['new_status'],
      changedBy: json['changed_by'],
      changedAt: json['changed_at'] != null
          ? DateTime.parse(json['changed_at'])
          : null,
    );
  }
}
