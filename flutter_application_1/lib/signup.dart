import 'package:flutter/material.dart';
import 'package:flutter_application_1/Authentication/authbloc/auth_bloc.dart';
import 'package:flutter_application_1/Authentication/authbloc/auth_event.dart';
import 'package:flutter_application_1/Authentication/authbloc/auth_state.dart';
import 'package:flutter_application_1/firebasedatabase/bloc/event.dart';
import 'package:flutter_application_1/firebasedatabase/bloc/storedatabloc.dart';
import 'package:flutter_application_1/firebasedatabase/firebaserepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginpage.dart';
import 'package:flutter_application_1/Theme/appcolors.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  String username = "";
  String password = "";

  final RegExp regExpUsername = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  final RegExp regExpPassword =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])(?!.*[ ]).{8,}$');

  final _formKey = GlobalKey<FormState>();

  bool isUsernameValid = false;
  bool isPasswordValid = false;
  bool isUsernameEmpty = true;
  bool isPasswordEmpty = true;

//  Future<void> addUserToDatabase(BuildContext context, String username) async {
//   final firestore = FirebaseFirestore.instance;
//   try {
//     await firestore.collection('users').add({
//       'username': username,
//       'createdAt': FieldValue.serverTimestamp(),
//       'loggedin':'yes'
//     });
//     // Show success message
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('User added successfully')),
//     );
//   } catch (e) {
//     // Show error message
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Failed to add user to database: $e')),
//     );
//   }
// }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Enter Your Details'),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is Authenticated) {

        // Check if the user is already in the Firestore database
                      final isFirstTime = await FirebaseRepository().isFirstTimeLogin(username);
                      if (isFirstTime) {
                        // If first time login, skip adding user to Firebase
                     BlocProvider.of<FirebaseBloc>(context).add(AddUserEvent(username));
       
                     
                  
                      }
                      else {
                     
   ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Welcome back! You are already registered.')),
                        );

                      }

            


   Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Loginpage()),
            );


            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => const Loginpage()),
            // );


          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }


        },
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 7,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: appcolors.textformfieldcolor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: appcolors.textformfieldcolor),
                    ),
                    errorBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: appcolors.textformfielderrorcolor),
                    ),
                    icon: const Icon(Icons.person_2_outlined),
                    iconColor: appcolors.textformfieldcolor,
                    errorStyle: const TextStyle(
                        color: appcolors.textformfielderrorcolor),
                    hintText: 'Enter your username.',
                    suffixIcon: isUsernameEmpty || !isUsernameValid
                        ? null
                        : const Icon(Icons.check, color: Colors.green),
                  ),
                  maxLength: 50,
                  onChanged: (value) {
                    setState(() {
                      username = value;
                      isUsernameEmpty = username.isEmpty;
                      isUsernameValid = regExpUsername.hasMatch(username);
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username cannot be empty.';
                    } else if (!regExpUsername.hasMatch(value)) {
                      return 'Invalid username format.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: appcolors.textformfieldcolor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: appcolors.textformfieldcolor),
                    ),
                    errorBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: appcolors.textformfielderrorcolor),
                    ),
                    icon: const Icon(Icons.password_outlined),
                    iconColor: appcolors.textformfieldcolor,
                    errorStyle: const TextStyle(
                        color: appcolors.textformfielderrorcolor),
                    hintText: 'Enter your password.',
                    suffixIcon: isPasswordEmpty || !isPasswordValid
                        ? null
                        : const Icon(Icons.check, color: Colors.green),
                  ),
                  maxLength: 20,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                      isPasswordEmpty = password.isEmpty;
                      isPasswordValid = regExpPassword.hasMatch(password);
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty.';
                    } else if (!regExpPassword.hasMatch(value)) {
                      return 'Password must contain uppercase, lowercase, digit, and special character.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {


                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('username', username+ password);
                      // await prefs.setString('password', password);

 
 context.read<AuthBloc>().add(LoginRequested(username, password),

                          );
   



                    }
  
                    
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
