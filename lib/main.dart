import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_bloc.dart';
import 'package:jobhunt_ftl/repository/repository.dart';
import 'package:jobhunt_ftl/screen/loginsreen.dart';
import 'package:jobhunt_ftl/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(MyApp());
  runApp(ProviderScope(child: MyApp()));
  // runApp(GetMaterialApp(
  //   home: LoginScreen(),
  //   builder: EasyLoading.init(),
  // ));
}

// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // MultiBlocProvider(
        //   providers: [
        //     BlocProvider<InsideBloc>(
        //       create: (BuildContext context) =>
        //           InsideBloc(insideFirebase: InsideService()),
        //     ),
        //   ],child:
        GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      builder: EasyLoading.init(),
      // ),
    );
  }
}
