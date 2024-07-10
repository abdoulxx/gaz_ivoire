import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gazivoire/constants/theme.dart';
import 'package:gazivoire/provider/app_provider.dart';
import 'package:gazivoire/screens/auth_ui/Welcome/Welcome.dart';
import 'package:gazivoire/screens/custome_bottom_bar/custome_bottom_bar.dart';
import 'package:provider/provider.dart';
import 'firebase_helper/firebase_firestore_helper/firebase_auth_helper.dart';
import 'firebase_helper/firebase_options/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Gaz'Ivoire",
        theme: themeData,
        home:StreamBuilder(
          stream : FirebaseAuthHelper.instance.getAuthChange,
          builder :(context , snaphost) {
            if (snaphost.hasData) {
              return const CustmBottonBar();
      }
            return const Welcome();
      }
        )
      ),
    );
  }
}
