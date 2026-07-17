import 'dart:io';
import 'package:employee_support_system/features/employees/data/models/ticket_model.dart';

abstract class TicketRemoteDatasource {
  Future<void> createTicket(TicketModel ticket , File? image) ;
Future<List<TicketModel>> getuserTickets(String userId) ;
  Future<void> allTickets();
}
