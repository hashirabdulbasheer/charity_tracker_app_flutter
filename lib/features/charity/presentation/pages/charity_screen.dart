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
        // _headerWidget(state),
        // const Divider(
        //   color: Colors.green,
        //   thickness: 2,
        // ),

        currentState.charities.isEmpty
            ? Expanded(child: Center(child: Text("errors.no_data".tr())))
            : Flexible(
                child: ListView.builder(
                itemCount: currentState.charities.length,
                itemBuilder: (context, index) {
                  return _charityWidget(context, currentState.charities[index], currentState);
                },
              ))
      ],
    );
  }

  void _addCharity(BuildContext context) {
    Navigator.of(context)
        .pushNamed(CharityDetailsScreen.routeName, arguments: null)
        .then((charity) {
      if (charity != null) {
        context.read<CharityBloc>().add(CharityAddEvent(charity: charity as Charity));
      }
    });
  }

  void _editCharity(BuildContext context, Charity charity) {
    Navigator.of(context)
        .pushNamed(CharityDetailsScreen.routeName, arguments: charity)
        .then((charity) {
      if (charity != null) {
        context.read<CharityBloc>().add(CharityUpdateEvent(charity: charity as Charity));
      }
    });
  }

  Widget _headerWidget(CharityLoadedState state) {
    // return FutureBuilder<List<Charity>>(
    //   future: state.charityDao.getAll(), // async work
    //   builder: (BuildContext context, AsyncSnapshot<List<Charity>> snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.waiting:
    //         return const Text('Loading....');
    //       default:
    //         if (snapshot.hasError) {
    //           return Text('Error: ${snapshot.error}');
    //         } else {
    //           double total = 0;
    //           List<Charity> charities = snapshot.data as List<Charity>;
    //           for (Charity c in charities) {
    //             total = total + c.amount;
    //           }
    //           return Padding(
    //             padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
    //             child: Center(
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   const Padding(
    //                     padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
    //                     child: Text("TOTAL"),
    //                   ),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.end,
    //                     crossAxisAlignment: CrossAxisAlignment.end,
    //                     children: [
    //                       Text(
    //                         total.toStringAsFixed(2),
    //                         style: const TextStyle(fontSize: 30),
    //                       ),
    //                       const Padding(
    //                         padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
    //                         child: Text(
    //                           "SAR",
    //                           style: TextStyle(fontSize: 14),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           );
    //         }
    //     }
    //   },
    // );
    return Container();
  }

  Widget _charityWidget(BuildContext context, Charity charity, CharityLoadedState state) {
    return Dismissible(
      onDismissed: (direction) {},
      key: Key("${charity.date}"),
      background: Container(color: Colors.red),
      confirmDismiss: (direction) async {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("confirm".tr()),
                content: Text("delete_confirmation_message".tr()),
                actions: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        context.read<CharityBloc>().add(CharityDeleteEvent(charity: charity));
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
      },
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
}
