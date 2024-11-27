import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/custom_button.dart';
import 'package:flutter_application_1/pages/delivery_progress_page.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  // user wants to pay

  void userTappedPay(){
    if (formKey.currentState!.validate()){
      // only show dialog if form is valid
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirme o pagamento"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Número do cartão: $cardNumber"),
                Text("Data de expiração: $expiryDate"),
                Text("Nome do dono do cartão: $cardHolderName"),
                Text("CVV: $cvvCode"),
              ],
            ),
          ),
          actions: [
            // cancel button
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text("Cancelar")),

            // confirm button
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryProgressPage()));
              }, 
              child: const Text("Confirmar"))


          ],
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Checkout"),
      ),

      body: Column(
        children: [

          // credit card
        CreditCardWidget(
          cardNumber: cardNumber, 
          expiryDate: expiryDate, 
          cardHolderName: cardHolderName, 
          cvvCode: cvvCode, 
          showBackView: isCvvFocused, 
          onCreditCardWidgetChange: (p0){}),

        // credit card form

        CreditCardForm(
          cardNumber: cardNumber, 
          expiryDate: expiryDate, 
          cardHolderName: cardHolderName, 
          cvvCode: cvvCode, 
          onCreditCardModelChange: (data){
            setState(() {
              cardNumber = data.cardNumber;
              expiryDate = data.expiryDate;
              cardHolderName = data.cardHolderName;
              cvvCode = data.cvvCode;
            });
          }, 
          formKey: formKey),

          const Spacer(),

          CustomButton(
            onTap: userTappedPay, 
            text: "Pague agora"),

          const SizedBox(height: 25,),

        ],
      ),
    );
  }
}