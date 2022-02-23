import 'package:flutter/material.dart';
import 'package:stop_watch/main_classes/stopwatch.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Adding Text controllers
  final _nameController= TextEditingController();
  final _emailController= TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Color(0xff3eb489),
      ),
      body: Center(
        child: _buildLoginForm(), //
      ),
    );
  }


  Widget _buildLoginForm(){
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField( // for user name
                // keyboardType: TextInputType.emailAddress,
                controller: _nameController,
                decoration: InputDecoration(
                  label: Text('Runner'),
                ),
                validator: (text) => text!.isEmpty ? 'please enter runner\'s name!' : null,
              ),

              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                validator: (text) {
                  if(text!.isEmpty){
                    return 'please enter email!';
                  }
                  // here we will define regrex expression
                  final regrex = RegExp('[^@]+@[^\.]+\..+');
                  if(!regrex.hasMatch(text)){
                    return 'enter valid email!';
                  }

                 return null;
                },
              ),

              // here we will create a button for validation
              SizedBox(height: 25,),
              TextButton(
                  onPressed: _validate,
                  child: Text('Continue', style: TextStyle(fontSize: 16, color: Color(0xff3eb489)),),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Color(0xff3eb489)),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  elevation: MaterialStateProperty.all(3)
                ),

              )
            ],
          ),
        ),

    );
  }
// Form Validator Function
  void _validate() {
    final form = _formKey.currentState;
    if(!form!.validate()){
      return;
    }
    final name= _nameController.text;
    final email= _emailController.text;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => StopWatch(name: name,email: email)
      )
    );
  }
}
