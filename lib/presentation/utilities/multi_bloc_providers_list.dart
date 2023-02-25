import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logics/bloc/sign_in/sign_in_page_bloc.dart';

class MultiBlocProviderList {
  MultiBlocProviderList();

  static List<BlocProvider> getProviders() {
    return <BlocProvider>[
      BlocProvider<SignInPageBloc>(
        create: (context) => SignInPageBloc(),
      ),
    ];
  }
}
