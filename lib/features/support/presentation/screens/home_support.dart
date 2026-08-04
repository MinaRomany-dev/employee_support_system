import 'package:employee_support_system/core/theme/color_manager.dart';
import 'package:employee_support_system/core/widgets/state_card.dart';
import 'package:employee_support_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:employee_support_system/features/employees/data/models/ticket_model.dart';
import 'package:employee_support_system/features/employees/presentation/bloc/ticket_bloc.dart';
import 'package:employee_support_system/features/employees/presentation/screen/widgets/ticket_card_shimmer.dart';
import 'package:employee_support_system/features/employees/presentation/screen/widgets/tickets_shimmer.dart';
import 'package:employee_support_system/features/support/presentation/widgets/ticket_card_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeSupport extends StatefulWidget {
  const HomeSupport({super.key});

  @override
  State<HomeSupport> createState() => _HomeSupportState();
}

class _HomeSupportState extends State<HomeSupport> {
  @override
  void initState() {
    super.initState();
    context.read<TicketBloc>().add(
      LoadAssignedTicketsEvent(
        userId: Supabase.instance.client.auth.currentUser!.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: ColorManager.primaryDark),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutEvent());
            },
          ),
        ],
        toolbarHeight: height * 0.1,
        backgroundColor: ColorManager.surface,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HelpDesk',
              style: TextStyle(
                fontSize: 23.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B1A33),
              ),
            ),
            Text(
              'Welcome, ${Supabase.instance.client.auth.currentUser?.userMetadata?["name"] ?? ""}',
              style: TextStyle(fontSize: 18.sp, color: const Color(0xFF60738E)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<TicketBloc, TicketState>(
          builder: (context, state) {
            if (state is AssignedTicketsLoading) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
                child: Column(
                  children: [
                    StatictisCardShimmer(),
                    ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: height * .015),
                      itemBuilder: (context, index) =>
                          const TicketCardShimmer(),
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ],
                ),
              );
            } else if (state is AssignedTicketsLoaded) {
              final tickets = state.tickets;
              return Column(
                children: [
                  // قسم الإحصائيات (Stat Cards)
                  GridView.count(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 16.h,
                    ),
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 1.8,
                    children: [
                      BuildStateCard(
                        icon: Icons.assignment_outlined,
                        iconColor: const Color(0xFF2A6DF4),
                        iconBgColor: const Color(0xFFE1EDFF),
                        value: tickets.length.toString(),
                        label: 'Total',
                      ),
                      BuildStateCard(
                        icon: Icons.info_outline,
                        iconColor: const Color(0xFF2A6DF4),
                        iconBgColor: const Color(0xFFE1EDFF),
                        value: tickets
                            .where((t) => t.status == TicketStatus.open)
                            .length
                            .toString(),
                        label: 'Open',
                      ),
                      BuildStateCard(
                        icon: Icons.pending_outlined,
                        iconColor: const Color(0xFFE08E2B),
                        iconBgColor: const Color(0xFFFDECD2),
                        value: tickets
                            .where((t) => t.status == TicketStatus.inProgress)
                            .length
                            .toString(),
                        label: 'In Progress',
                      ),
                      BuildStateCard(
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
                  SizedBox(height: height * 0.02),
                  if (tickets.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.05),
                          Icon(
                            Icons.inbox_outlined,
                            size: 64.sp,
                            color: const Color(0xFF60738E),
                          ),
                          SizedBox(height: height * 0.015),
                          Text(
                            'No tickets yet',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: const Color(0xFF60738E),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 13.h),
                          child: TicketCardSupport(ticket: tickets[index]),
                        );
                      },
                    ),
                ],
              );
            } else {
              return const Center(child: Text('Something went wrongfgfgf'));
            }
          },
        ),
      ),
    );
  }
}
