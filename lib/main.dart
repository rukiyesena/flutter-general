import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uzum_general/store/Customer/CustomerRepository.dart';
import 'package:uzum_general/store/Login/LoginCubit.dart';

import 'full-pages/login.dart';
import 'models/UserModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserModel()),
      ],
      child: MaterialApp(
          home: BlocProvider(
            create: (context) => LoginCubit(CustomerRepository()),
            child: Login(),
          ),
        ),
    );
  }
}
