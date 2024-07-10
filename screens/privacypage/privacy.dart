import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Politique de confidentialité', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Politique de confidentialité de l'application Gaz'Ivoire",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                    "Dernière mise à jour : [20/01/2024]\n\n"
                    "Bienvenue sur l'application Gaz'Ivoire . Cette politique de confidentialité a pour but de vous informer sur la manière dont nous recueillons, utilisons et partageons vos informations personnelles lorsque vous utilisez notre application.\n\n"
                    "## Informations que nous recueillons\n\n"
                    "### Informations que vous fournissez volontairement\n\n"
                    "Lorsque vous utilisez notre application, nous pouvons vous demander de fournir certaines informations personnelles telles que votre nom, votre adresse e-mail, votre numéro de téléphone et d'autres informations nécessaires à la fourniture de nos services.\n\n"
                    "### Données de localisation\n\n"
                    "Si vous utilisez des fonctionnalités basées sur la localisation, nous pouvons collecter des informations sur votre emplacement géographique.\n\n"
                    "Nous utilisons les informations que nous recueillons dans le but de vous fournir, maintenir, protéger et améliorer notre application, ainsi que pour développer de nouveaux services. Ces utilisations peuvent inclure, sans s'y limiter :\n\n"
                    "- Personnaliser votre expérience utilisateur\n"
                    "- Fournir des services et fonctionnalités demandés\n"
                    "- Analyser et améliorer nos services\n"
                    "- Vous envoyer des communications liées à l'application\n\n"
                    "## Partage d'informations avec des tiers\n\n"
                    "Nous pouvons partager vos informations personnelles avec des tiers dans les cas suivants :\n"
                    "- Avec votre consentement\n"
                    "- Pour respecter des obligations légales\n"
                    "- Pour protéger nos droits et notre propriété\n"
                    "- En cas de fusion, acquisition ou vente d'actifs\n\n"
                    "## Sécurité\n\n"
                    "Nous mettons en œuvre des mesures de sécurité raisonnables pour protéger vos informations contre la perte, l'accès non autorisé, la divulgation, l'altération ou la destruction.\n\n"
                    "## Modifications de cette politique de confidentialité\n\n"
                    "Nous nous réservons le droit de mettre à jour cette politique de confidentialité à tout moment. Les modifications prendront effet immédiatement après leur publication sur cette page.\n\n"
                    "## Contactez-nous\n\n"
                    "Si vous avez des questions ou des préoccupations concernant notre politique de confidentialité, veuillez nous contacter à gazivoire@gmail.com.\n\n"
                    "Merci d'utiliser l'application Gaz'Ivoire !",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 20),
              // ... Ajoutez le reste du contenu ici, en utilisant Text pour chaque section du document
            ],
          ),
        ),
      ),
    );
  }
}
