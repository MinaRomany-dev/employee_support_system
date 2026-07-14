import 'dart:io';
import 'package:employee_support_system/core/resources/styles_manager.dart';
import 'package:employee_support_system/core/theme/color_manager.dart';
import 'package:employee_support_system/core/validator/validator.dart';
import 'package:employee_support_system/core/widgets/custom_elevated_button.dart';
import 'package:employee_support_system/core/widgets/customtxtfield.dart';
import 'package:employee_support_system/features/employees/data/models/ticket_model.dart';
import 'package:employee_support_system/features/employees/domain/entity/ticket_entity.dart';
import 'package:employee_support_system/features/employees/presentation/bloc/ticket_bloc.dart';
import 'package:employee_support_system/features/employees/presentation/screen/attachments_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({super.key});

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  File? iamgeUrl;
  final cleint = Supabase.instance.client;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TicketCategory? _selectedCategory;
  TicketPriority? _selectedPriority;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heightscreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(
        backgroundColor: ColorManager.surface,
        title: Text(
          'Create New Ticket',
          style: getSemiBoldStyle(
            fontSize: 18.sp,
            color: ColorManager.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5.w),
        child: Form(
          key: _formKey,
          child: Card(
            //margin: EdgeInsets.all(50),
            color: ColorManager.surface,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// title
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    validator: Validators.tickettitle,
                    controller: _titleController,
                    label: 'Ticket Title',
                    hint: 'e.g., Cannot access Slack corporate account',
                    prefixIcon: Icons.title_outlined,
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  /// description
                  CustomTextField(
                    controller: _descriptionController,
                    label: 'Description & Details',
                    hint:
                        'Describe the problem as clearly as possible. Include steps to reproduce if applicable...',
                    prefixIcon: Icons.description_outlined,
                    maxLines: 4,
                  ),

                  SizedBox(height: heightscreen * 0.02),

                  /// category
                  Text(
                    'Category',
                    style: TextStyle(
                      color: ColorManager.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  DropdownButtonFormField<TicketCategory>(
                    
                    dropdownColor: ColorManager.surface,
                    validator: Validators.ticketcategory,
                    hint: Text("Select Category"),
                    initialValue: _selectedCategory,
                    items: TicketCategory.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      _selectedCategory = value!;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorManager.border),
                        borderRadius: BorderRadius.all(Radius.circular(14.r)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorManager.border),
                        borderRadius: BorderRadius.all(Radius.circular(14.r)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorManager.border),
                        borderRadius: BorderRadius.all(Radius.circular(14.r)),
                      ),
                      prefixIcon: Icon(
                        Icons.category_outlined,
                        color: ColorManager.textSecondary,
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  // priority
                  Text(
                    'Priority Level',
                    style: TextStyle(
                      color: ColorManager.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  DropdownButtonFormField<TicketPriority>(
                    dropdownColor: ColorManager.surface,
                    validator: Validators.ticketpriority,
                    hint: Text("Select Priority"),
                    initialValue: _selectedPriority,
                    items: TicketPriority.values
                        .map(
                          (priority) => DropdownMenuItem(
                            value: priority,
                            child: Text(priority.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      _selectedPriority = value!;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorManager.border),
                        borderRadius: BorderRadius.all(Radius.circular(14.r)),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorManager.border),
                        borderRadius: BorderRadius.all(Radius.circular(14.r)),
                      ),
                      prefixIcon: Icon(
                        Icons.priority_high_outlined,
                        color: ColorManager.textSecondary,
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                  /// attachments
                  AttachmentsSection(ontap: ontap, selectedImage: iamgeUrl),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  CustomButton(
                    text: 'Submit Ticket',
                    style: getSemiBoldStyle(
                      fontSize: 17.sp,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        TicketEntity entry = TicketEntity(
                          createdAt: DateTime.now(),
                          updatedAt: null,
                          assignedTo: null,
                          createdBy: cleint.auth.currentUser!.id,
                          status: TicketStatus.open,
                          id: '',
                          image: null,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          category: _selectedCategory!,
                          priority: _selectedPriority!,
                        );

                        if (iamgeUrl != null) {
                          context.read<TicketBloc>().add(
                            CreateTicketEvent(ticket: entry, image: iamgeUrl),
                          );
                        } else {
                          context.read<TicketBloc>().add(
                            CreateTicketEvent(ticket: entry, image: null),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void ontap(File? fileimage) {
    setState(() {
      iamgeUrl = fileimage;
    });
  }
}
