import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/charity/presentation/bloc/charity_bloc.dart';
import '../../features/charity/presentation/pages/charity_details_screen.dart';
import '../../features/charity/presentation/pages/charity_screen.dart';
import 'di_container.dart';

class CharityRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CharityDetailsScreen.routeName:
        if (settings.arguments != null) {
          CharityDetailsScreenArguments args = settings.arguments as CharityDetailsScreenArguments;
          final page = CharityDetailsScreen(
            charity: args.charity,
            isEditAllowed: args.isEditAllowed,
          );
          return MaterialPageRoute(builder: (context) => page);
        } else {
          const page = CharityDetailsScreen(charity: null, isEditAllowed: true);
          return MaterialPageRoute(builder: (context) => page);
        }

      default:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => CharityBloc(
                          createUseCase: sl(),
                          updateUseCase: sl(),
                          deleteUseCase: sl(),
                          getAllUseCase: sl())
                        ..add(CharityLoadEvent()),
                    ),
                  ],
                  child: const CharityScreen(),
                ));
    }
  }
}
