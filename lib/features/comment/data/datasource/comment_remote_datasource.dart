import 'package:employee_support_system/features/comment/data/models/comment_model.dart';

abstract class Commentremotedatasource {
 Stream<List<CommentModel>> getComment(String ticketid);
 Future<void> addComment(CommentModel comment);
}
