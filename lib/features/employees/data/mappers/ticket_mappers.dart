import 'package:employee_support_system/features/employees/data/models/ticket_model.dart';
import 'package:employee_support_system/features/employees/domain/entity/ticket_entity.dart';

extension TicketMapper on TicketModel {
  TicketEntity toEntity() => TicketEntity(
    id: id,
    title: title,
    description: description,
    image: attachmentUrl,
    status: status,
    priority: priority,
    assignedToName: assignedToName,
    createdByName: createdByName,
    category: category,
    createdAt: createdAt,
    updatedAt: updatedAt,
    createdBy: createdBy,
    assignedTo: assignedTo,
  );
}

extension TicketMappers on TicketEntity {
  TicketModel toModel() => TicketModel(
    id: id,
    title: title,
    description: description,
    attachmentUrl: image,
    status: status,
    priority: priority,
    category: category,
    createdAt: createdAt,
    updatedAt: updatedAt,
    createdBy: createdBy,
    assignedTo: assignedTo,
  );
}
