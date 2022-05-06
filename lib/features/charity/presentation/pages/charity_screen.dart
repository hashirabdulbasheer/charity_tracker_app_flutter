import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/misc/date_utils.dart';
import '../../../../core/misc/dialog_utils.dart';
import '../../domain/entities/charity.dart';
import '../bloc/charity_bloc.dart';
import 'charity_details_screen.dart';

class CharityScreen extends StatelessWidget {
  const CharityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharityBloc, CharityState>(listener: (context, state) {
      if (state is CharityErrorState) {
        CharityErrorState errorState = state;
        DialogUtils.showGeneralDialog(context, "errors.error".tr(), errorState.message);
      } else if (state is CharitySuccessState) {
        CharitySuccessState successState = state;
        var snackBar = SnackBar(content: Text(successState.message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }, builder: (context, state) {
      return _body(context, state);
    });
  }

  ///
  /// WIDGETS
  ///

  Widget _body(BuildContext context, CharityState state) {
    Widget body = _loadingBody();
    if (state is CharityLoadedState) {
      body = _mainBody(context, state);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("app_name".tr()),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<CharityBloc>().add(CharityLoadEvent());
                },
                icon: const Icon(Icons.refresh, color: Colors.white))
          ],
        ),
        body: body,
        floatingActionButton: (state is CharityLoadedState)
            ? FloatingActionButton(
                onPressed: () => _addCharity(context),
                tooltip: 'actions.add'.tr(),
                child: const Icon(Icons.add))
            : null);
  }

  /// Displays a loading progress
  Widget _loadingBody() {
    return const Center(child: CircularProgressIndicator());
  }

  /// Displays the main content
  Widget _mainBody(BuildContext context, CharityLoadedState currentState) {
    return Column(
      children: [
        _headerWidget(currentState),
        const Divider(color: Colors.green, thickness: 2),
        currentState.charities.isEmpty
            ? Expanded(child: Center(child: Text("errors.no_data".tr())))
            : Flexible(
                child: ListView.separated(
                itemCount: currentState.charities.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return _charityWidget(context, currentState.charities[index], currentState);
                },
              ))
      ],
    );
  }

  /// Displays the header with total amount
  Widget _headerWidget(CharityLoadedState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text("TOTAL"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  state.totalAmount.toStringAsFixed(2),
                  style: const TextStyle(fontSize: 30),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                  child: Text(
                    "SAR",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Displays the details of a charity entry
  Widget _charityWidget(BuildContext context, Charity charity, CharityLoadedState state) {
    return Dismissible(
      onDismissed: (direction) {},
      key: Key("${charity.date}"),
      background: Container(color: Colors.red),
      confirmDismiss: (direction)  => _deleteCharity(context, charity),
      child: ListTile(
        onTap: () {
          _editCharity(context, charity);
        },
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      charity.description,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${'by'.tr()} ${charity.createdBy}",
                      style: const TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${'on'.tr()} ${CharityDateUtils.formattedDate(charity.date)}",
                      style: const TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(charity.formattedAmount, style: const TextStyle(fontSize: 40)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 8),
                          child: Text(charity.currency, style: const TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      charity.type,
                      style: const TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// ACTIONS
  ///

  /// Add action
  void _addCharity(BuildContext context) {
    CharityDetailsScreenArguments args =
    CharityDetailsScreenArguments(charity: null, isEditAllowed: true);
    Navigator.of(context)
        .pushNamed(CharityDetailsScreen.routeName, arguments: args)
        .then((charity) {
      if (charity != null) {
        context.read<CharityBloc>().add(CharityAddEvent(charity: charity as Charity));
      }
    });
  }

  /// Edit action
  void _editCharity(BuildContext context, Charity charity) {
    bool isEditAllowed = context.read<CharityBloc>().isEditAllowed(charity);
    CharityDetailsScreenArguments args =
    CharityDetailsScreenArguments(charity: charity, isEditAllowed: isEditAllowed);
    Navigator.of(context)
        .pushNamed(CharityDetailsScreen.routeName, arguments: args)
        .then((charity) {
      if (charity != null) {
        context.read<CharityBloc>().add(CharityUpdateEvent(charity: charity as Charity));
      }
    });
  }

  /// Delete action
  Future<bool?> _deleteCharity(BuildContext context, Charity charity) {
    CharityBloc charityBloc = BlocProvider.of<CharityBloc>(context);
    bool isEditAllowed = charityBloc.isEditAllowed(charity);
    if (!isEditAllowed) {
      // only allow delete if edit is allowed
      return Future.value(false);
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("confirm".tr()),
            content: Text("delete_confirmation_message".tr()),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    charityBloc.add(CharityDeleteEvent(charity: charity));
                    Navigator.of(context).pop();
                  },
                  child: Text("actions.delete".tr())),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("actions.cancel".tr()),
              ),
            ],
          );
        });
  }

}
