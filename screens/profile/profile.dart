import 'package:flutter/material.dart';
import 'package:gazivoire/firebase_helper/firebase_firestore_helper/firebase_auth_helper.dart';
import 'package:gazivoire/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../mdp_oublie2/mdpoublie.dart';
import '../../provider/app_provider.dart';
import '../auth_ui/mdp_oublie/mdpoublie.dart';
import '../edit_profile/edit_profile.dart';
import '../privacypage/about.dart';
import '../privacypage/faq.dart';
import '../privacypage/privacy.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Compte', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                child: Column(
                  children: [
                    appProvider.getUserInformation.image == null
                        ? const Icon(
                            Icons.person_outline,
                            size: 80,
                          )
                        : CircleAvatar(
                      backgroundImage: NetworkImage(appProvider.getUserInformation.image ?? ''),
                      radius: 50,
                    ),

                    Text(
                      appProvider.getUserInformation.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      appProvider.getUserInformation.email,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    /*SizedBox(
                      width: 140,
                      child: PrimaryButton(
                        title: "Edit Profile",
                        textColor: Colors.white,
                        onpressed: () {
                          Routes.instance.push(
                              widget: const EditProfile(), context: context);
                        },
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                         Routes.instance.push(
                         widget: const EditProfile(), context: context);
                        },
                    leading: const Icon(Icons.person),
                    title: const Text("Mes informations"),
                  ),

                  ListTile(
                    onTap: () {
                      Routes.instance.push(
                          widget:  AboutUsPage(), context: context);                    },
                    leading: const Icon(Icons.info_outline),
                    title: const Text("A propos de Gaz'Ivoire"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance.push(
                          widget:  FAQPage(), context: context);                    },
                    leading: const Icon(Icons.question_mark),
                    title: const Text("FAQ"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance.push(
                          widget:  PrivacyPolicyPage(), context: context);
                    },
                    leading: const Icon(Icons.info_outline),
                    title: const Text("Politique de confidentialite"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance.push(widget: ForgotMdp2(), context: context);
                    },
                    leading: const Icon(Icons.password_outlined),
                    title: const Text("Modifier mot de passe"),
                  ),
                  ListTile(
                    onTap: () {
                      FirebaseAuthHelper.instance.signOut();
                      setState(() {});
                    },
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text("Deconnexion"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
