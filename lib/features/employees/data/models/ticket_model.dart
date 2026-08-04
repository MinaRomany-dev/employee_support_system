enum TicketStatus { open, inProgress, resolved, closed }

enum TicketCategory { itSupport, hr, finance, facilities, general }

enum TicketPriority { low, medium, high }

// class TicketModel {
//   final String id;
//   final String title;
//   final String description;
//   final TicketCategory category;
//   final TicketStatus status;
//   final TicketPriority priority;
//   final String createdBy;
//   final String? assignedTo;
//   final DateTime createdAt;
//   final DateTime? updatedAt;
//   final String? attachmentUrl;

//   TicketModel({
//     this.attachmentUrl,
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.status,
//     required this.priority,
//     required this.category,
//     required this.createdBy,
//     this.assignedTo,
//     required this.createdAt,
//     this.updatedAt,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'description': description,
//       'status': status.name,
//       'priority': priority.name,
//       'category': category.name,
//       'created_by': createdBy,
//       'assigned_to': assignedTo,
//       'attachmentUrl': attachmentUrl,
//     };
//   }

//   factory TicketModel.fromJson(Map<String, dynamic> json) {
//     return TicketModel(
//       id: json['ticketId'],
//       title: json['title'],
//       description: json['description'],
//       status: TicketStatus.values.byName(json['status']),
//       priority: TicketPriority.values.byName(json['priority']),
//       category: TicketCategory.values.byName(json['category']),
//       createdBy: json['created_by'],
//       assignedTo: json['assigned_to'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: json['updated_at'] != null
//           ? DateTime.parse(json['updated_at'])
//           : null,
//       attachmentUrl: json['attachmentUrl'],
//     );
//   }
// }
class TicketModel {
  final String id;
  final String title;
  final String description;
  final TicketCategory category;
  final TicketStatus status;
  final TicketPriority priority;
  final String createdBy;
  final String? createdByName;
  final String? assignedTo;
  final String? assignedToName;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? attachmentUrl;

  TicketModel({
    this.attachmentUrl,
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.category,
    required this.createdBy,
    this.createdByName,
    this.assignedTo,
    this.assignedToName,
    required this.createdAt,
    this.updatedAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['ticketId'],
      title: json['title'],
      description: json['description'],
      status: TicketStatus.values.byName(json['status']),
      priority: TicketPriority.values.byName(json['priority']),
      category: TicketCategory.values.byName(json['category']),
      createdBy: json['created_by'],
      createdByName: json['creator']?['name'],
      assignedTo: json['assigned_to'],
      assignedToName: json['assignee']?['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      attachmentUrl: json['attachmentUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'status': status.name,
      'priority': priority.name,
      'category': category.name,
      'created_by': createdBy,
      'assigned_to': assignedTo,
      'attachmentUrl': attachmentUrl,
    };
  }
}
