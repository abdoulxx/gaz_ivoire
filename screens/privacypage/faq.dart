import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Foire aux questions",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              SizedBox(height: 20),
              QuestionAnswer(
                question: "Comment passer une commande de gaz ?",
                answer: "Pour passer une commande, choisissez un opérateur dans l'application, sélectionnez le type de gaz et la quantité, puis suivez les instructions pour finaliser votre commande.",
              ),
              QuestionAnswer(
                question: "Quels sont les modes de paiement acceptés ?",
                answer: "Les paiements se font à la livraison une fois les bouteilles remises.",
              ),
              QuestionAnswer(
                question: "Comment puis-je suivre ma livraison ?",
                answer: "Une fois votre commande confirmée, nous vous appelons pour les détails de livraison : heure, date, et autres.",
              ),
              QuestionAnswer(
                question: "Que faire en cas de problème avec ma livraison ?",
                answer: "Si vous rencontrez des problèmes avec votre livraison, veuillez nous contacter immédiatement à gazivoire@gmail.com.",
              ),
              // Ajoutez plus de questions-réponses au besoin
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionAnswer extends StatelessWidget {
  final String question;
  final String answer;

  const QuestionAnswer({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          answer,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
