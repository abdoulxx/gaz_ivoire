import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gazivoire/constants/constants.dart';
import 'package:gazivoire/firebase_helper/firebase_firestore_helper/firebase_auth_helper.dart';
import 'package:gazivoire/screens/auth_ui/mdp_oublie/mdpoublie.dart';
import 'package:gazivoire/screens/auth_ui/sign_up/sign_up.dart';
import 'package:gazivoire/screens/home/home.dart';

import '../../../constants/routes.dart';
import '../../../widgets/primary_button/primary_button.dart';
import '../../custome_bottom_bar/custome_bottom_bar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading:
            const BackButton(), // Placer le bouton de retour en haut à gauche
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 0),
            const Center(
              child: Text(
                "Gaz'Ivoire",
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
            const SizedBox(height: 60),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  "Hello!",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900], // Texte en bleu
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  "Heureux de vous revoir",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900], // Texte en bleu
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: email, // Utilisez le contrôleur email
                  decoration: const InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: password, // Utilisez le contrôleur password

                  obscureText: isShowPassword,
                  decoration: InputDecoration(
                    hintText: "Mot de passe",
                    prefixIcon: const Icon(
                      Icons.password_outlined,
                      color: Colors.grey,
                    ),
                    suffixIcon: CupertinoButton(
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: PrimaryButton(
                onpressed: () async {
                  bool isValidated = loginValidation(email.text, password.text);
                  if (isValidated){
                   bool isLogined = await FirebaseAuthHelper.instance.login(email.text, password.text, context);
                   if (isLogined){
                     Routes.instance.pushAndRemoveUntil(widget: CustmBottonBar(), context: context);

                   }
                  }
                },
                title: "Se Connecter",
                textColor: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Routes.instance
                        .push(widget: const SignUp(), context: context);
                  },
                  child: Text(
                    "Créer un compte",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Routes.instance
                        .push(widget: const ForgotMdp(), context: context);
                  },
                  child: Text(
                    "Mot de passe oublié",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
