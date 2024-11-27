import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/restaurant.dart';
import 'package:provider/provider.dart';

class CurrentLocation extends StatelessWidget{
  final TextEditingController textController;

  const CurrentLocation({
    super.key,
    required this.textController
    });

    void openLocationSearchBox(BuildContext context){

      showDialog(context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Sua Localização"),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: "Pesquisar Endereço"
          ),
        ),
        actions: [
          //cancel button
          MaterialButton(onPressed: (){
            Navigator.pop(context);
            textController.clear();
          },
          child: const Text("Cancelar")),
          // save button
          MaterialButton(onPressed: (){
            String newAddress = textController.text;
            context.read<Restaurant>().updateDeliveryAddress(newAddress);
            Navigator.pop(context);
            textController.clear();
          },
          child: const Text("Salvar")),

        ],
      ));
    }

  @override
  Widget build(BuildContext context){
    return Padding(padding: const EdgeInsets.all(25.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Entregar agora",
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary)),
          GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
              // address
              Consumer<Restaurant>(
                builder: (context, restaurant, child) => 
                Text(restaurant.deliveryAddress, 
                      style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
          ),),
    
          // dropdown menu
          const Icon(Icons.keyboard_arrow_down_rounded),
        ],),
          )
      ],
    ),);
  }
}