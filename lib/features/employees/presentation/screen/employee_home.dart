import 'package:employee_support_system/core/routes/routes.dart';
import 'package:employee_support_system/core/theme/color_manager.dart';
import 'package:employee_support_system/features/employees/data/models/ticket_model.dart';
import 'package:employee_support_system/features/employees/domain/entity/ticket_entity.dart';
import 'package:employee_support_system/features/employees/presentation/bloc/ticket_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HelpDeskScreen extends StatefulWidget {
  const HelpDeskScreen({super.key});

  @override
  State<HelpDeskScreen> createState() => _HelpDeskScreenState();
}

class _HelpDeskScreenState extends State<HelpDeskScreen> {
  @override
  void initState() {
    super.initState();
    // بيتعمل مرة واحدة لما الشاشة تفتح
    context.read<TicketBloc>().add(
      LoadUserTicketsEvent(
        userId: Supabase.instance.client.auth.currentUser!.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // لما الشاشة تفتح، جيب الـ tickets تلقائي

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.pushNamed(context, Routes.ticketscreen);

          if (mounted) {
            context.read<TicketBloc>().add(
              LoadUserTicketsEvent(
                userId: Supabase.instance.client.auth.currentUser!.id,
              ),
            );
          }
        },
        backgroundColor: const Color(0xFF2A6DF4),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('New Ticket', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: BlocBuilder<TicketBloc, TicketState>(
          builder: (context, state) {
            // loading
            if (state is TicketLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            }

            // error
            if (state is TicketLoadingError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    Text(state.message),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context.read<TicketBloc>().add(
                        LoadUserTicketsEvent(
                          userId: Supabase.instance.client.auth.currentUser!.id,
                        ),
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            // loaded
            final tickets = state is TicketLoaded
                ? state.tickets
                : <TicketEntity>[];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'HelpDesk Lite',
                                  style: TextStyle(
                                    fontSize: 27.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0B1A33),
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                Text(
                                  'Welcome, ${Supabase.instance.client.auth.currentUser?.userMetadata?["name"] ?? ""}',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Color(0xFF60738E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: width * .1,
                            height: height * .1,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF2A6DF4),
                              ),
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              color: Color(0xFF2A6DF4),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // Stats — من الـ tickets الحقيقية
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 1.7.sp,
                        children: [
                          _buildStatCard(
                            icon: Icons.assignment_outlined,
                            iconColor: const Color(0xFF2A6DF4),
                            iconBgColor: const Color(0xFFE1EDFF),
                            value: tickets.length.toString(),
                            label: 'Total',
                          ),
                          _buildStatCard(
                            icon: Icons.info_outline,
                            iconColor: const Color(0xFF2A6DF4),
                            iconBgColor: const Color(0xFFE1EDFF),
                            value: tickets
                                .where((t) => t.status == TicketStatus.open)
                                .length
                                .toString(),
                            label: 'Open',
                          ),
                          _buildStatCard(
                            icon: Icons.pending_outlined,
                            iconColor: const Color(0xFFE08E2B),
                            iconBgColor: const Color(0xFFFDECD2),
                            value: tickets
                                .where(
                                  (t) => t.status == TicketStatus.inProgress,
                                )
                                .length
                                .toString(),
                            label: 'In Progress',
                          ),
                          _buildStatCard(
                            icon: Icons.check_circle_outline,
                            iconColor: const Color(0xFF2AA85C),
                            iconBgColor: const Color(0xFFE1F5E8),
                            value: tickets
                                .where((t) => t.status == TicketStatus.resolved)
                                .length
                                .toString(),
                            label: 'Resolved',
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      const Text(
                        'My Ticket History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0B1A33),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Empty state
                      if (tickets.isEmpty)
                        Center(
                          child: Column(
                            children: const [
                              SizedBox(height: 40),
                              Icon(
                                Icons.inbox_outlined,
                                size: 64,
                                color: Color(0xFF60738E),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'No tickets yet',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF60738E),
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: tickets.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _buildTicketCard(tickets[index], context),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTicketCard(TicketEntity ticket, BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, Routes.login, arguments: ticket),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFEEF2F7)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badges
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                _buildBadge(
                  label: ticket.category.name,
                  bgColor: const Color(0xFFE1EDFF),
                  textColor: const Color(0xFF1A5BC7),
                ),
                _buildPriorityBadge(ticket.priority),
                _buildStatusBadge(ticket.status),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              ticket.title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0B1A33),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              ticket.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14.5,
                height: 1.5,
                color: Color(0xFF60738E),
              ),
            ),

            const SizedBox(height: 14),
            const Divider(height: 1, color: Color(0xFFEEF2F7)),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMetaItem(
                  Icons.calendar_today_outlined,
                  _formatDate(ticket.createdAt),
                ),
                if (ticket.assignedTo != null)
                  _buildMetaItem(
                    Icons.headset_mic_outlined,
                    ticket.assignedTo!,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ────────────────────────────────
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
    return _buildBadge(label: priority.name, bgColor: bg, textColor: text);
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
    return _buildBadge(label: status.name, bgColor: bg, textColor: text);
  }

  Widget _buildBadge({
    required String label,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFEEF2F7)),
      ),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .1,
            height: 44,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0B1A33),
                ),
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 13, color: Color(0xFF60738E)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFF60738E), size: 15),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 13.5, color: Color(0xFF3D5670)),
        ),
      ],
    );
  }
}
