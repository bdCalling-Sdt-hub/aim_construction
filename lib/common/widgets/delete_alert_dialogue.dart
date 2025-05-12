
import 'package:aim_construction/common/widgets/spacing.dart';
import 'package:aim_construction/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_button.dart';
import 'custom_outlinebutton.dart';

class DeleteAlertDialogue extends StatelessWidget {
  const DeleteAlertDialogue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppString.deleteText),
      content: Text(AppString.areYouSureText),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 5,
              child: horizontalSpacing(10.w),
            ),
            Expanded(
              flex: 5,
              child: CustomOutlineButton(
                onTap: () {
                  Navigator.of(context)
                      .pop(); // Close the dialog
                },
                text: "No",
              ),
            ),
            horizontalSpacing(10.w),
            Expanded(
              flex: 5,
              child: CustomButton(
                color: Colors.redAccent,
                onTap: () {
                  // Perform delete operation here
                  Navigator.of(context)
                      .pop(); // Close the dialog
                },
                text: "Yes",
              ),
            ),
          ],
        ),
      ],
    );
  }
}