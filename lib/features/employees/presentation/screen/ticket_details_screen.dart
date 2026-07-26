import 'package:employee_support_system/core/di/di.dart';
import 'package:employee_support_system/core/theme/color_manager.dart';
import 'package:employee_support_system/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:employee_support_system/features/comment/presentation/widgets/ticket_chat_screen.dart';
import 'package:employee_support_system/features/employees/data/models/ticket_model.dart';
import 'package:employee_support_system/features/employees/domain/entity/ticket_entity.dart';
import 'package:employee_support_system/functions_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TicketDetailsScreen extends StatefulWidget {
  final TicketEntity ticket;
  const TicketDetailsScreen({super.key, required this.ticket});
  // 15000
  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ticket = widget.ticket;
    final height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => getIt<CommentBloc>(),

      child: BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF4F6FA),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.5,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF0B1A33),
                  size: 18,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                'Ticket Details',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0B1A33),
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 20.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Ticket Info Card ─────────────────────
                        buildCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Priority + Status row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildPriorityBadge(ticket.priority),
                                  _buildStatusBadge(ticket.status),
                                ],
                              ),

                              SizedBox(height: height * 0.015),

                              // Title
                              Text(
                                ticket.title,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF0B1A33),
                                ),
                              ),

                              SizedBox(height: 6.h),

                              // Category
                              Text(
                                'Category: ${ticket.category.name}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF2A6DF4),
                                ),
                              ),

                              Divider(
                                height: height * 0.03,
                                color: const Color(0xFFEEF2F7),
                              ),

                              // Description label
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF60738E),
                                ),
                              ),

                              SizedBox(height: 6.h),

                              Text(
                                ticket.description,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xFF0B1A33),
                                  height: 1.5,
                                ),
                              ),

                              Divider(
                                height: height * 0.03,
                                color: const Color(0xFFEEF2F7),
                              ),

                              // Submitted by + Assigned to
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          maxLines: 1,
                                          'Submitted by',
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: const Color(0xFF60738E),
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          ticket.createdByName ?? 'Unknown',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF0B1A33),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Assigned to',
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: const Color(0xFF60738E),
                                          ),
                                        ),
                                        //  dart => garbage collector => dispose
                                        //  security
                                        /// clean code
                                        /// state management
                                        SizedBox(height: 4.h),
                                        Text(
                                          ticket.assignedToName ??
                                              'Not assigned yet',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            color: ticket.assignedTo != null
                                                ? ColorManager.primary
                                                : ColorManager.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: height * 0.01),

                              // Date
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 13.sp,
                                    color: const Color(0xFF60738E),
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    Functions.formatDate(ticket.createdAt),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(0xFF60738E),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: height * 0.02),

                        // ── History Section ──────────────────────
                        buildSectionTitle('Audit Trail & History'),
                        SizedBox(height: 8.h),
                        buildCard(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.history,
                                    size: 36.sp,
                                    color: const Color(0xFFCDD5E0),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'No history yet',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: const Color(0xFF60738E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: TicketChatScreen(ticketId: widget.ticket.id)),
                // ── Comment Input ────────────────────────────
                Container(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 10.h,
                    bottom: MediaQuery.of(context).padding.bottom + 10.h,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Color(0xFFEEF2F7))),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          minLines: 1,
                          maxLines: 3,
                          //  textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(fontSize: 14.sp),
                          decoration: InputDecoration(
                            hintText: 'Add a comment...',
                            hintStyle: TextStyle(
                              //
                              fontSize: 13.sp,
                              color: const Color(0xFF9BA8B5),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            fillColor: const Color(0xFFF4F6FA),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.r),
                              borderSide: const BorderSide(
                                color: Color(0xFFEEF2F7),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.r),
                              borderSide: const BorderSide(
                                color: Color(0xFFEEF2F7),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.r),
                              borderSide: const BorderSide(
                                color: Color(0xFF2A6DF4),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      IconButton(
                        icon: Icon(
                          Icons.send_rounded,
                          color: const Color(0xFF2A6DF4),
                          size: 24.sp,
                        ),
                        onPressed: () {
                          if (_commentController.text.isNotEmpty) {
                            context.read<CommentBloc>().add(
                              AddCommentEvent(
                                userId: Supabase
                                    .instance
                                    .client
                                    .auth
                                    .currentUser!
                                    .id,
                                ticketId: widget.ticket.id,
                                content: _commentController.text,
                              ),
                            );
                          }
                          _commentController.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── Widgets ───────────────────────────────────

  Widget buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFEEF2F7)),
      ),
      child: child,
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0B1A33),
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(TicketPriority priority) {
    final colors = {
      TicketPriority.high: (ColorManager.highBg, const Color(0xFFC0392B)),
      TicketPriority.medium: (ColorManager.mediumBg, const Color(0xFF9E6F1F)),
      TicketPriority.low: (ColorManager.lowBg, const Color(0xFF2AA85C)),
    };
    final (bg, text) = colors[priority]!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        'Priority: ${priority.name}',
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          color: text,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(TicketStatus status) {
    final colors = {
      TicketStatus.open: ColorManager.openText,
      TicketStatus.inProgress: ColorManager.inProgressText,
      TicketStatus.resolved: ColorManager.resolvedText,
      TicketStatus.closed: ColorManager.closedText,
    };
    final color = colors[status]!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status.name,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
