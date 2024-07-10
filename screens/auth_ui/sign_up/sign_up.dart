import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../constants/routes.dart';
import '../../../firebase_helper/firebase_firestore_helper/firebase_auth_helper.dart';
import '../../../widgets/primary_button/primary_button.dart';
import '../../custome_bottom_bar/custome_bottom_bar.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isShowPassword = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(),
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
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  "Bienvenue!",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  "Créez votre compte",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    hintText: "Nom et prénoms",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
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
            const SizedBox(height: 12),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: password,

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
            const SizedBox(height: 12),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: phone,

                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: "Numéro de téléphone",
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: PrimaryButton(

                onpressed: () async{
                  bool isValidated = signUpValidation(email.text, password.text, name.text,phone.text);
                  if (isValidated){
                    bool isLogined = await FirebaseAuthHelper.instance.signUp(name.text, email.text,password.text,phone.text, context);
                    if (isLogined){
                      Routes.instance.pushAndRemoveUntil(widget: const CustmBottonBar(), context: context);

                    }
                  }
                },
                title: "Créer mon compte",
                textColor: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "j'ai déjà un compte",
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
