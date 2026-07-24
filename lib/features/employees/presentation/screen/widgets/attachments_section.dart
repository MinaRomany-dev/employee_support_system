import 'dart:io';

import 'package:employee_support_system/core/resources/styles_manager.dart';
import 'package:employee_support_system/core/theme/color_manager.dart';
import 'package:employee_support_system/functions_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttachmentsSection extends StatefulWidget {
  final File? selectedImage;
  final void Function(File? image)? ontap;

  const AttachmentsSection({super.key, this.ontap, this.selectedImage});

  @override
  State<AttachmentsSection> createState() => _AttachmentsSectionState();
}

class _AttachmentsSectionState extends State<AttachmentsSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * .4,
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.attach_file, size: 22.sp),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Text(
                "Reference image",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height * .05),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.selectedImage == null
                    ? Icon(
                        Icons.image_outlined,
                        size: 40.sp,
                        color: Colors.grey,
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .2,
                        child: Image.file(widget.selectedImage!),
                      ),

                // SizedBox(height: MediaQuery.of(context).size.height * .013),
                ElevatedButton.icon(
                  icon: Icon(Icons.image, color: ColorManager.whiteColor),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          "Select Image",
                          style: getRegularStyle(
                            fontSize: 18.sp,
                            color: ColorManager.textPrimary,
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text("Camera"),
                              onTap: () async {
                                final selectedImage =
                                    await Functions.cameraPicker();
                                if (selectedImage != null) {
                                  widget.ontap!(selectedImage);
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo),
                              title: const Text("Gallery"),
                              onTap: () async {
                                final selectedImage =
                                    await Functions.galleryPicker();
                                if (selectedImage != null) {
                                  widget.ontap!(selectedImage);
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                  ),

                  label: Text(
                    "Select Image",
                    style: getRegularStyle(color: ColorManager.whiteColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
