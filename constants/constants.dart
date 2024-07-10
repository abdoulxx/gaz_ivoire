import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.blue.shade900,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(
      builder: (context) {
        return SizedBox(
          width: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               CircularProgressIndicator(
                color: Colors.blue.shade900,
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                margin: const EdgeInsets.only(left: 7),
                child: const Text("Chargement"),
              )
            ],
          ),
        );
      },
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "L'adresse e-mail est déjà utilisée. Veuillez vous rendre à la page de connexion.";
    case "account_exists_with_different_credentials":
      return "L'adresse e-mail est déjà utilisée. Veuillez vous rendre à la page de connexion.";
    case "email_already_in_use":
      return "L'adresse e-mail est déjà utilisée. Veuillez vous rendre à la page de connexion.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong_password":
      return "Mot de passe incorrect";
    case "ERROR_USER_NOT_FOUND":
    case "user_not_found":
      return "Aucun utilisateur trouvé avec cette adresse e-mail";
    case "ERROR_USER_DISABLED":
      return "Utilisateur désactivé";
    case "ERROR_TOO_MANY_REQUESTS":
    case "operation_not_allowed":
      return "Trop de demandes pour se connecter à ce compte";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Trop de demandes pour se connecter à ce compte";
    case "ERROR_INVALID_EMAIL":
    case "invalid_email":
      return "L'adresse e-mail est invalide";
    case "invalide e-mail":
      return "L'adresse e-mail est invalide";
    default:
      return "Échec de la connexion. Veuillez réessayer.";
  }
}


bool loginValidation(String email, String password) {
  print('Email: $email');
  print('Password: $password');

  if (email.isEmpty && password.isEmpty) {
    showMessage("Les deux champs sont vides");
    return false;
  } else if (email.isEmpty) {
    showMessage("L'email est vide");
    return false;
  } else if (password.isEmpty) {
    showMessage("Le mot de passe est vide");
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage("All fields are empty");
    return false;
  } else if (name.isEmpty) {
    showMessage("Name is empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is empty");
    return false;
  } else if (phone.isEmpty) {
    showMessage("Phone is empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password is empty");
    return false;
  } else {
    return true;
  }
}