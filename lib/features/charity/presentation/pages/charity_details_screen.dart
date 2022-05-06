import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/configs/charity_configs.dart';
import '../../../../core/enums/charity_type.dart';
import '../../../../core/misc/date_utils.dart';
import '../../data/models/mappers/charity_mappers.dart';
import '../../domain/entities/charity.dart';

class CharityDetailsScreen extends StatefulWidget {
  static const routeName = '/details';
  final Charity? charity;

  const CharityDetailsScreen({Key? key, this.charity}) : super(key: key);

  @override
  State<CharityDetailsScreen> createState() => _CharityDetailsScreenState();
}

class _CharityDetailsScreenState extends State<CharityDetailsScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  CharityType _selectedType = CharityType.notAssigned;

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.charity?.description ?? "";
    _amountController.text = widget.charity?.formattedAmount ?? "";
    _selectedType = CharityMapper.stringToCharityType(widget.charity?.type ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                        hintText: "details.desc_hint".tr(), labelText: "details.desc_label".tr()),
                    maxLines: 1,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                        hintText: "details.amount_hint".tr(),
                        labelText: "details.amount_label".tr()),
                    maxLines: 1,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<CharityType>(
                          items: _dropdownItems,
                          onChanged: (value) {
                            setState(() {
                              _selectedType = value ?? CharityType.notAssigned;
                            });
                          },
                          value: _selectedType,
                          isExpanded: true),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              String desc = _descriptionController.text;
                              String amount = _amountController.text;
                              if (desc != "" && amount != "") {
                                double amountDouble = 0.0;
                                try {
                                  amountDouble = double.parse(amount);
                                  Charity charity = Charity(
                                      description: desc,
                                      amount: amountDouble,
                                      currency: CharityConfig.currency,
                                      date: CharityDateUtils.currentTimestamp,
                                      createdBy: CharityConfig.currentUser,
                                      type: _selectedType.rawValue(),
                                      key: widget.charity?.key ?? "");
                                  Navigator.of(context).pop(charity);
                                } catch (_) {}
                              }
                            },
                            child: Text(_title))),
                  ],
                )
              ],
            ),
          ),
        ));
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

  String get _title {
    if (widget.charity == null) {
      return "actions.add".tr();
    }
    return "actions.update".tr();
  }
}
