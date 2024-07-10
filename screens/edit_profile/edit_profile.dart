import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gazivoire/models/user_model/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../../widgets/primary_button/primary_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController deliveryAddressController = TextEditingController();


  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Pré-remplir les champs avec les informations existantes de l'utilisateur
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    nameController.text = appProvider.getUserInformation.name;
    emailController.text = appProvider.getUserInformation.email;
    phoneController.text = appProvider.getUserInformation.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          image == null
              ? CupertinoButton(
            onPressed: () {
              takePicture();
            },
            child: const CircleAvatar(
                radius: 80, child: Icon(Icons.camera_alt)),
          )
              : CupertinoButton(
            onPressed: () {
              takePicture();
            },
            child: CircleAvatar(
              backgroundImage: FileImage(image!),
              radius: 80,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: "Nom",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: "E-mail",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: phoneController,
            decoration: const InputDecoration(
              hintText: "Numéro de téléphone",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
            child:   PrimaryButton(
              title: "Mettre a jour",
              textColor: Colors.white,
              onpressed: () async {
                UserModel userModel = appProvider.getUserInformation
                    .copyWith(
                  name: nameController.text,
                  email: emailController.text,
                  phoneNumber: phoneController.text,

                );
                appProvider.updateUserInfoFirebase(context, userModel, image);

              },
            ),
          ),
        ],
      ),
    );
  }
}
