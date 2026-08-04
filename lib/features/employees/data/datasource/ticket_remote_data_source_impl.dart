import 'dart:io';

import 'package:employee_support_system/core/error/exception_handler.dart';
import 'package:employee_support_system/features/employees/data/datasource/ticket_remote_datasource.dart';
import 'package:employee_support_system/features/employees/data/models/ticket_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: TicketRemoteDatasource)
class TicketRemoteDataSourceImpl implements TicketRemoteDatasource {
  final SupabaseClient client;
  const TicketRemoteDataSourceImpl(this.client);

  @override
  Future<void> allTickets() {
    // TODO: implement allTickets
    throw UnimplementedError();
  }

  @override
  Future<List<TicketModel>> getAssignedTickets(String userId) async {
    try {
      final data = await client
          .from('tickets')
          .select('''
      *,
      creator:users!created_by(name),
      assignee:users!assigned_to(name)
    ''')
          .eq('assigned_to', userId)
          .order('created_at', ascending: false);
      return data.map((m) => TicketModel.fromJson(m)).toList();
    } catch (e) {
      throw handleException(e);
    }
  }

  @override
  Future<void> createTicket(TicketModel ticket, File? image) async {
    try {
      String? attachmentUrl;
      if (image != null) {
        final time = DateTime.now().microsecondsSinceEpoch.toString();
        final uniquepath = "${time}_${image.path.split('/').last}";
        await client.storage.from('attachments').upload(uniquepath, image);
        attachmentUrl = client.storage
            .from('attachments')
            .getPublicUrl(uniquepath);
      }
      final response = ticket.toJson();
      final newTicketId = response['id'];
      if (attachmentUrl != null) response['attachmentUrl'] = attachmentUrl;
      await client.from('tickets').insert(response);
      await client.from('tickets_history').insert({
        'ticket_id': newTicketId,
        'old_status': ticket.status.name,
        "changed_by": ticket.createdBy,
      });
    } catch (e) {
      throw handleException(e);
    }
  }

  @override
  Future<List<TicketModel>> getuserTickets(String userId) async {
    try {
      final data = await client
          .from('tickets')
          .select('''
      *,
      creator:users!created_by(name),
      assignee:users!assigned_to(name)
    ''')
          .eq('created_by', userId)
          .order('created_at', ascending: false);

      return data.map((m) => TicketModel.fromJson(m)).toList();
    } catch (e) {
      throw handleException(e);
    }
  }

  @override
  Future<void> updateTicketStatus({
    required String ticketId,
    required TicketStatus oldStatus,
    required TicketStatus newStatus,
    required String changedBy,
  }) async {
    try {
      await client
          .from('tickets')
          .update({'status': newStatus.name})
          .eq('ticketId', ticketId);

      await client.from('tickets_history').insert({
        'ticket_id': ticketId,
        'old_status': oldStatus.name,
        'new_status': newStatus.name,
        'changed_by': changedBy,
      });
    } catch (e) {
      throw handleException(e);
    }
  }
}
