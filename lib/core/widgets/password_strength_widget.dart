import 'package:flutter/material.dart';

class PasswordStrengthWidget extends StatefulWidget {
  const PasswordStrengthWidget({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  State<PasswordStrengthWidget> createState() =>
      _PasswordStrengthWidgetState();
}


class _PasswordStrengthWidgetState extends State<PasswordStrengthWidget> {

  double strength = 0;

  String text = "";

  Color color = Colors.transparent;


  @override
  void initState() {
    super.initState();

    widget.passwordController.addListener(_checkPassword);
  }



  void _checkPassword() {

    final password = widget.passwordController.text;


    double newStrength = 0;


    if(password.isEmpty){

      newStrength = 0;

    }

    else {

      if(password.length >= 8){
        newStrength += .25;
      }


      if(password.contains(RegExp(r'[A-Z]'))){
        newStrength += .25;
      }


      if(password.contains(RegExp(r'[0-9]'))){
        newStrength += .25;
      }


      if(password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
        newStrength += .25;
      }

    }



    setState(() {

      strength = newStrength;


      if(strength <= .25){

        text = "Weak";

        color = Colors.red;

      }

      else if(strength <= .75){

        text = "Medium";

        color = Colors.orange;

      }

      else {

        text = "Strong";

        color = Colors.green;

      }


    });


  }




  @override
  void dispose() {

    widget.passwordController.removeListener(_checkPassword);

    super.dispose();

  }





  @override
  Widget build(BuildContext context) {


    if(strength == 0){

      return const SizedBox.shrink();

    }



    return AnimatedContainer(

      duration:
      const Duration(milliseconds: 300),


      margin: const EdgeInsets.only(top: 8),


      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,


        children: [


          Row(

            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,


            children: [


              const Text(

                "Password strength",

                style: TextStyle(

                  fontSize: 12,

                  color: Colors.grey,

                ),

              ),



              AnimatedSwitcher(

                duration:
                const Duration(milliseconds: 250),


                child: Text(

                  text,

                  key: ValueKey(text),

                  style: TextStyle(

                    fontSize: 12,

                    fontWeight:
                    FontWeight.bold,

                    color: color,

                  ),

                ),

              ),

            ],

          ),




          const SizedBox(height: 6),





          ClipRRect(

            borderRadius:
            BorderRadius.circular(20),


            child: LinearProgressIndicator(

              value: strength,


              minHeight: 6,


              backgroundColor:
              Colors.grey.shade200,


              valueColor:
              AlwaysStoppedAnimation<Color>(color),

            ),

          ),


        ],

      ),

    );


  }

}