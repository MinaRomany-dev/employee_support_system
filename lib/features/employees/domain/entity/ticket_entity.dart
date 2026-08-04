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

  TicketEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    String? createdByName,
    String? assignedToName,
    TicketCategory? category,
    TicketPriority? priority,
    String? createdBy,
    String? assignedTo,
    TicketStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TicketEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      createdByName: createdByName ?? this.createdByName,
      assignedToName: assignedToName ?? this.assignedToName,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      createdBy: createdBy ?? this.createdBy,
      assignedTo: assignedTo ?? this.assignedTo,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
