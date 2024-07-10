import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gazivoire/constants/constants.dart';
import 'package:gazivoire/firebase_helper/firebase_firestore_helper/firebase_auth_helper.dart';

import '../../../widgets/primary_button/primary_button.dart';

class ForgotMdp extends StatefulWidget {
  const ForgotMdp({super.key});

  @override
  State<ForgotMdp> createState() => _LoginState();
}

class _LoginState extends State<ForgotMdp> {
  bool isShowPassword = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

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
            const SizedBox(height: 60),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  "Oops!",
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
                  "Mot de passe oublie?",
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
                  controller: newpassword,
                  obscureText: isShowPassword,
                  decoration: InputDecoration(
                    hintText: "Nouveau mot de passe",
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
              height: 12,
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: confirmpassword,
                  obscureText: isShowPassword,
                  decoration: InputDecoration(
                    hintText: " confirmez nouveau mot de passe",
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
                onpressed: () async{
                  if(newpassword.text.isEmpty){
                    showMessage("nouveau mot de passe vide");
                  } else if(confirmpassword.text.isEmpty){
                    showMessage("confirme mot de passe est vide");
                  } else{
                    if(confirmpassword.text ==newpassword.text){
                      FirebaseAuthHelper.instance.changePassword(
                          newpassword.text, context);
                    }else{
                      showMessage("les deux mot de passe sont pas identique");
                    }

                  }

                },
                title: "Modifier",
                textColor: Colors.white,

              ),
            ),
            const SizedBox(height: 15),

          ],
        ),
      ),
    );
  }
}
