import 'package:employee_support_system/core/error/exception_handler.dart';
import 'package:employee_support_system/features/comment/data/datasource/CommentRemoteDatasource.dart';
import 'package:employee_support_system/features/comment/data/models/comment_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: Commentremotedatasource)
class CommentRemoteDatasourceImpl implements Commentremotedatasource {
  final SupabaseClient client;

  const CommentRemoteDatasourceImpl(this.client);
  @override
  Future<void> addComment(CommentModel comment) async {
    try {
      await client.from('comments').insert(comment.toJson());
    } catch (e) {
      throw handleException(e);
    }
  }

  @override
  Stream<List<CommentModel>> getComment(String ticketId) async* {
    await for (final _
        in client
            .from('comments')
            .stream(primaryKey: ['id'])
            .eq('ticket_id', ticketId)) {
      final data = await client
          .from('comments')
          .select('*, sender:users!user_id(name, role)')
          .eq('ticket_id', ticketId)
          .order('created_at', ascending: true);
      yield data.map((json) => CommentModel.fromJson(json)).toList();
    }
  }
}
