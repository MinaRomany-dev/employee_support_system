import 'package:employee_support_system/features/comment/domain/entities/comment_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/styles_manager.dart';
import '../../../../core/theme/color_manager.dart';

class ChatBubble extends StatelessWidget {
  final CommentEntity message;
  final bool isMe;
  final bool showAvatar;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.showAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isMe)
            SizedBox(
              width: 42.w,
              child: showAvatar
                  ? CircleAvatar(
                      radius: 18.r,
                      backgroundColor: ColorManager.primary,
                      child: Text(
                        message.senderName![0].toUpperCase(),
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  : const SizedBox(),
            ),

          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * .72,
            ),
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (showAvatar)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Text(
                      "${message.senderName ?? 'Unknown'} • ${message.senderRole ?? 'Unknown'}",
                      style: getMediumStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? ColorManager.primary : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.r),
                      topRight: Radius.circular(18.r),
                      bottomLeft: Radius.circular(isMe ? 18.r : 4.r),
                      bottomRight: Radius.circular(isMe ? 4.r : 18.r),
                    ),
                    border: isMe
                        ? null
                        : Border.all(color: const Color(0xffE5E7EB)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        message.content,
                        style: getRegularStyle(
                          fontSize: 15.sp,
                          color: isMe ? Colors.white : Colors.black87,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        _formatTime(message.createdAt),
                        style: getRegularStyle(
                          fontSize: 11.sp,
                          color: isMe ? Colors.white70 : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (isMe)
            SizedBox(
              width: 42.w,
              child: showAvatar
                  ? CircleAvatar(
                      radius: 18.r,
                      backgroundColor: ColorManager.primary,
                      child: Text(
                        message.senderName![0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  : const SizedBox(),
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime date) {
    final hour = date.hour > 12 ? date.hour - 12 : date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final amPm = date.hour >= 12 ? "PM" : "AM";
    return "$hour:$minute $amPm";
  }
}
