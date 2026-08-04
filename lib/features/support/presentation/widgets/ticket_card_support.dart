import 'package:employee_support_system/core/routes/routes.dart';
import 'package:employee_support_system/core/theme/color_manager.dart';
import 'package:employee_support_system/core/widgets/ticket_badge.dart';
import 'package:employee_support_system/features/employees/data/models/ticket_model.dart';
import 'package:employee_support_system/features/employees/domain/entity/ticket_entity.dart';
import 'package:employee_support_system/features/employees/presentation/bloc/ticket_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TicketCardSupport extends StatefulWidget {
  final TicketEntity ticket;

  const TicketCardSupport({super.key, required this.ticket});

  @override
  State<TicketCardSupport> createState() => _TicketCardSupportState();
}

class _TicketCardSupportState extends State<TicketCardSupport> {
  TicketStatus? _status;
  @override
  void initState() {
    super.initState();
    _status = widget.ticket.status;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.ticketDetailsScreen,
        arguments: widget.ticket,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xFFEEF2F7)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 20.w,
              runSpacing: 6.h,
              children: [
                TicketBadge(
                  label: widget.ticket.category.name,
                  bgColor: const Color(0xFFE1EDFF),
                  textColor: const Color(0xFF1A5BC7),
                ),
                _buildPriorityBadge(widget.ticket.priority),
                _buildStatusBadge(widget.ticket.status),
              ],
            ),
            SizedBox(height: height * 0.015),
            Text(
              widget.ticket.title,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B1A33),
              ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              widget.ticket.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.5.sp,
                height: 1.5,
                color: const Color(0xFF60738E),
              ),
            ),
            SizedBox(height: height * 0.017),
            const Divider(height: 1, color: Color(0xFFEEF2F7)),
            SizedBox(height: height * 0.015),

            ///  Status and Date Row
            BlocListener<TicketBloc, TicketState>(
              listener: (context, state) {
                if (state is! UpdateTicketStatusFailure) {
                  setState(() {});
                }
                if (state is UpdateTicketStatusFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: ColorManager.primaryDark,
                          //   size: 15.sp,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.06,
                        ),
                        Expanded(
                          child: Text(
                            _formatDate(widget.ticket.createdAt),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: ColorManager.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Status Dropdown
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: DropdownButtonFormField<TicketStatus>(
                      isExpanded: true,
                      hint: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        _status?.name ?? 'Select Status',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                      dropdownColor: ColorManager.surface,
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: ColorManager.textMuted,
                      ),

                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.border),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.border),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.border),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      items: TicketStatus.values
                          .where((s) => s != TicketStatus.open)
                          .map(
                            (s) =>
                                DropdownMenuItem(value: s, child: Text(s.name)),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          _status = value;
                          context.read<TicketBloc>().add(
                            UpdateTicketStatusEvent(
                              ticketId: widget.ticket.id,
                              oldStatus: widget.ticket.status,
                              newStatus: value,
                              changedBy:
                                  Supabase.instance.client.auth.currentUser!.id,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy · hh:mm a').format(date);
  }

  Widget _buildPriorityBadge(TicketPriority priority) {
    final colors = {
      TicketPriority.high: (const Color(0xFFFCE3E3), const Color(0xFFC0392B)),
      TicketPriority.medium: (const Color(0xFFFEF4E0), const Color(0xFF9E6F1F)),
      TicketPriority.low: (const Color(0xFFE7F6EC), const Color(0xFF2AA85C)),
    };
    final (bg, text) = colors[priority]!;
    return TicketBadge(label: priority.name, bgColor: bg, textColor: text);
  }

  Widget _buildStatusBadge(TicketStatus status) {
    final colors = {
      TicketStatus.open: (const Color(0xFFE1EDFF), const Color(0xFF2A6DF4)),
      TicketStatus.inProgress: (
        const Color(0xFFFDECD2),
        const Color(0xFFB56C1D),
      ),
      TicketStatus.resolved: (const Color(0xFFE1F5E8), const Color(0xFF2AA85C)),
      TicketStatus.closed: (const Color(0xFFF1F1F1), const Color(0xFF60738E)),
    };
    final (bg, text) = colors[status]!;
    return TicketBadge(label: status.name, bgColor: bg, textColor: text);
  }
}
