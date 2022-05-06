import 'package:flutter/material.dart';
import '../../features/charity/domain/entities/charity.dart';
import '../../features/charity/presentation/widgets/charity_details_dialog_widget.dart';
import '../enums/charity_type.dart';

class DialogUtils {

  /// Displays a generic dialog with title and message
  static void showGeneralDialog(BuildContext context, String title, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: const Text('Close')),
            ],
          );
        });
  }

  static void showCharityDetailsDialog(
      {required BuildContext context,
      required String actionTitle,
      Charity? charity,
      required TextEditingController descriptionController,
      required TextEditingController amountController,
      required CharityType selectedType,
      required Function(CharityType) onCharityTypeSelected,
      required Function onConfirmed}) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(actionTitle),
      onPressed: () {
        onConfirmed();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(actionTitle),
      content: CharityDialogWidget(
        charity: charity,
        descriptionController: descriptionController,
        amountController: amountController,
        selectedType: selectedType,
        onCharityTypeSelected: onCharityTypeSelected,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
