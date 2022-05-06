import 'package:flutter/material.dart';
import '../../../../core/enums/charity_type.dart';
import '../../domain/entities/charity.dart';

class CharityDialogWidget extends StatelessWidget {
  final Charity? charity;
  final TextEditingController descriptionController;
  final TextEditingController amountController;
  final CharityType selectedType;
  final Function(CharityType) onCharityTypeSelected;

  const CharityDialogWidget(
      {Key? key,
      this.charity,
      required this.descriptionController,
      required this.amountController,
      required this.selectedType,
      required this.onCharityTypeSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 250,
        child: Column(
          children: [
            TextField(
              controller: descriptionController,
              decoration:
                  const InputDecoration(hintText: "Enter description", labelText: "Description"),
              maxLines: 2,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(hintText: "Enter amount", labelText: "Amount"),
              maxLines: 1,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<CharityType>(
                      items: _dropdownItems,
                      onChanged: (value) => onCharityTypeSelected,
                      value: selectedType,
                      isExpanded: true),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<CharityType>> get _dropdownItems {
    List<DropdownMenuItem<CharityType>> menuItems = [
      DropdownMenuItem(value: CharityType.zakat, child: Text(CharityType.zakat.rawValue())),
      DropdownMenuItem(value: CharityType.sadaqa, child: Text(CharityType.sadaqa.rawValue())),
      DropdownMenuItem(value: CharityType.interest, child: Text(CharityType.interest.rawValue())),
      DropdownMenuItem(
          value: CharityType.notAssigned, child: Text(CharityType.notAssigned.rawValue()))
    ];
    return menuItems;
  }
}
