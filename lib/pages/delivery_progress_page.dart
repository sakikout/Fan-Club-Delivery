import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/receipt.dart';
import 'package:flutter_application_1/models/restaurant.dart';
import 'package:flutter_application_1/services/auth/database/firestore.dart';
import 'package:provider/provider.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  // get access to db
  FirestoreService db = FirestoreService();

  @override
  void initState(){
    super.initState();

    // if we get to this page, submite order to firestore db
    String receipt = context.read<Restaurant>().displayCartReceipt();
    db.saveOrderToDatabase(receipt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery"),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
      body: Column(
        children: [
          Receipt(),
        ],
      ),
    );
  }

  // Custom Bottom Nav Bar
  Widget _buildBottomNavBar(BuildContext context){
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
          ),
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          // driver profile pic
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.person)),
          ),

          const SizedBox(width: 10,),

          // driver details

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text("José Pereira",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.inversePrimary
                ),),
                Text("Motorista",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary)
                ),
            ],
          ),

          const Spacer(),

          Row(
            children: [
          // message button
           Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.message)),
          ),
          
          const SizedBox(width: 10,),

          // call button
           Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.call),
              color: Colors.green,),
          ),

            ],
          )

        ],
      ),
    );
  }
}
