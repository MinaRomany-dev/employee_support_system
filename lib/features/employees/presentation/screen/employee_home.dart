import 'package:employee_support_system/core/routes/routes.dart';
import 'package:employee_support_system/core/theme/color_manager.dart';
import 'package:employee_support_system/core/widgets/state_card.dart';
import 'package:employee_support_system/core/widgets/tickets_card.dart';
import 'package:employee_support_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:employee_support_system/features/employees/data/models/ticket_model.dart';
import 'package:employee_support_system/features/employees/domain/entity/ticket_entity.dart';
import 'package:employee_support_system/features/employees/presentation/bloc/ticket_bloc.dart';
import 'package:employee_support_system/features/employees/presentation/screen/widgets/ticket_card_shimmer.dart';
import 'package:employee_support_system/features/employees/presentation/screen/widgets/tickets_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

class HelpDeskScreen extends StatefulWidget {
  const HelpDeskScreen({super.key});

  @override
  State<HelpDeskScreen> createState() => _HelpDeskScreenState();
}

class _HelpDeskScreenState extends State<HelpDeskScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TicketBloc>().add(
      LoadUserTicketsEvent(
        userId: Supabase.instance.client.auth.currentUser!.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.login,
                  (route) => false,
                );
              }
            },
            child: IconButton(
              icon: const Icon(Icons.logout, color: ColorManager.primary),
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
              },
            ),
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
      backgroundColor: const Color(0xFFF4F6FA),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, Routes.ticketscreen),
        backgroundColor: const Color(0xFF2A6DF4),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('New Ticket', style: TextStyle(color: Colors.white)),
      ),

      /// Body
      body: SafeArea(
        child: BlocBuilder<TicketBloc, TicketState>(
          builder: (context, state) {
            if (state is TicketLoading) {
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
            }

            if (state is TicketLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
                    SizedBox(height: height * 0.015),
                    Text(state.message),
                    SizedBox(height: height * 0.015),
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

            final tickets = state is TicketLoaded
                ? state.tickets
                : <TicketEntity>[];

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// State Cards
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 1.7,
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
                                .where(
                                  (t) => t.status == TicketStatus.inProgress,
                                )
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

                      SizedBox(height: height * 0.035),
                      Text(
                        'My Ticket History',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B1A33),
                        ),
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
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: tickets.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: TicketCard(ticket: tickets[index]),
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
}
