import 'package:employee_support_system/core/routes/routes.dart';
import 'package:employee_support_system/core/widgets/ticket_badge.dart';
import 'package:employee_support_system/core/widgets/ticket_meta_item.dart';
import 'package:employee_support_system/features/employees/data/models/ticket_model.dart';
import 'package:employee_support_system/features/employees/domain/entity/ticket_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TicketCard extends StatelessWidget {
  final TicketEntity ticket;

  const TicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.ticketDetailsScreen,
        arguments: ticket,
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
                  label: ticket.category.name,
                  bgColor: const Color(0xFFE1EDFF),
                  textColor: const Color(0xFF1A5BC7),
                ),
                _buildPriorityBadge(ticket.priority),
                _buildStatusBadge(ticket.status),
              ],
            ),
            SizedBox(height: height * 0.015),
            Text(
              ticket.title,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B1A33),
              ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              ticket.description,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TicketMetaItem(
                  icon: Icons.calendar_today_outlined,
                  text: _formatDate(ticket.createdAt),
                ),
                if (ticket.assignedTo != null)
                  TicketMetaItem(
                    icon: Icons.headset_mic_outlined,
                    text: ticket.assignedToName!,
                  ),
              ],
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
