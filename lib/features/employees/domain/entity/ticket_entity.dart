import 'package:employee_support_system/features/employees/data/models/ticket_model.dart';

class TicketEntity {
  final String id;
  final String title;
  final String description;
  final String? image;
  final String? createdByName; // ← ضيف
  final String? assignedToName;
  final TicketCategory category;
  final TicketPriority priority;
  final String createdBy;
  final String? assignedTo;
  final TicketStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  TicketEntity({
    this.createdByName,
    this.assignedToName,
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.category,
    required this.priority,
    required this.createdBy,
    required this.assignedTo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}
