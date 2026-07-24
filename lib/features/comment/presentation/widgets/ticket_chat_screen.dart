import 'package:employee_support_system/core/resources/styles_manager.dart';
import 'package:employee_support_system/core/theme/color_manager.dart';
import 'package:employee_support_system/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'chat_bubble.dart';

class TicketChatScreen extends StatefulWidget {
  final String ticketId;
  const TicketChatScreen({super.key, required this.ticketId});

  @override
  State<TicketChatScreen> createState() => _TicketChatScreenState();
}

class _TicketChatScreenState extends State<TicketChatScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CommentBloc>().add(LoadCommentsEvent(widget.ticketId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentsLoaded) {
          final messages = state.comments.reversed.toList();
          if (messages.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 15.h),
              child: Container(
                width: double.infinity,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFEEF2F7)),
                ),
                child: Center(
                  child: Text(
                    'No messages yet',
                    style: getSemiBoldStyle(
                      fontSize: 15.sp,
                      color: ColorManager.textSecondary,
                    ),
                  ),
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 15.h),
            child: Container(
              width: double.infinity,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFFEEF2F7)),
              ),
              child: ListView.builder(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                itemCount: state.comments.length,
                itemBuilder: (_, index) {
                  final message = messages[index];

                  final showAvatar =
                      index == 0 ||
                      messages[index - 1].senderName != message.senderName;

                  return ChatBubble(
                    message: message,
                    isMe:
                        message.userId ==
                        Supabase.instance.client.auth.currentUser!.id,
                    showAvatar: showAvatar,
                  );
                },
              ),
            ),
          );
        } else if (state is CommentsLoading) {
          return const Center(
            child: CircularProgressIndicator(color: ColorManager.primary),
          );
        } else {
          return Center(child: Text('No comments yet'));
        }
      },
    );
  }
}
