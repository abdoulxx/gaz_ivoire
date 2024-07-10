import 'package:flutter/material.dart';
import 'package:gazivoire/screens/auth_ui/sign_up/sign_up.dart';

import '../../../constants/routes.dart';
import '../../../widgets/primary_button/primary_button.dart';
import '../login/login.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Center(
                child: Text("Gaz'Ivoire",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 32)),
              ),
              const SizedBox(
                height: 60,
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                  child: Image.asset(
                "assets/images/accueil.png",
              )),
              const SizedBox(
                height: 70,
              ),
               Center(
                child: Text(
                    "Gaz Ivoire vous offre une expérience pratique et sécurisée pour"
                    " commander votre gaz en quelques clics. Profitez de la commodité de la livraison à domicile",
                  style: TextStyle(color: Colors.blue.shade900, fontSize: 18, fontWeight: FontWeight.bold),

                ),
              ),
              const SizedBox(
                height: 70,
              ),
              PrimaryButton(
                onpressed: () {
                  Routes.instance.push(widget: const Login(), context: context);
                },
                title: "Se Connecter",
                textColor: Colors.white,
              ),
              const SizedBox(
                height: 18,
              ),
              PrimaryButton(
                onpressed: () {
                  Routes.instance
                      .push(widget: const SignUp(), context: context);
                },
                title: "Inscription",
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
