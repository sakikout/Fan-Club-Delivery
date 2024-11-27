import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/custom_textfield.dart';
import 'package:flutter_application_1/components/custom_button.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';


class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap,});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  // text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // register method

  void register() async {
    // get auth service

    final _authService = AuthService();

    // check if passwords match
    if (passwordController.text == confirmPasswordController.text){
      // try creating user
      try {
        await _authService.signUpWithEmailAndPassword(emailController.text, passwordController.text);
      } catch (e) {
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ));
      }
    } else {
      // if passwords don't match
         showDialog(
          context: context, 
          builder: (context) => AlertDialog(
          title: Text("As senhas precisam ser as mesmas."),
        ));

    }

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        // logo 
          Image.asset("assets/logo/fa_clube_logo.png",
          height: 200,
          width: 200,),

        const SizedBox(height: 25),
        
        // slogan
        Text("Vamos criar uma conta para você!",
        style: TextStyle(
          fontSize: 16, 
          color: Theme.of(context).colorScheme.inversePrimary)
          ),
        
        const SizedBox(height: 25),
        // email textfield
        CustomTextfield( 
          controller: emailController,
          hintText: "Email",
          obscureText: false,
          ),

        const SizedBox(height: 25),

        // password textfield
        CustomTextfield( 
          controller: passwordController,
          hintText: "Senha",
          obscureText: true,
          ),

        const SizedBox(height: 25),

        // confirm password textfield
        CustomTextfield( 
          controller: confirmPasswordController,
          hintText: "Confirmar Senha",
          obscureText: true,
          ),

        const SizedBox(height: 25),
        
        // sign up button
        CustomButton(text: "Registrar-se", onTap: (){
          register();
        },),

        const SizedBox(height: 25),

        // Already have an account? Login here

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Já possui uma conta?", style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary)),
          const SizedBox(width: 4,),
          GestureDetector(
            onTap: widget.onTap,
            child: Text("Entre aqui!", style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold)),
          )
          
        ],)

      ],)
        ,)
    );
  }
}
