import 'package:finalproject/firebase_options.dart';
import 'package:finalproject/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.cyan),
      ),
      home: const MyHomePage(title: 'DriveX'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _econtroller = TextEditingController();
  final TextEditingController _pcontroller = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  late String _email, _password, _username;
  bool password = true;
  final auth = FirebaseAuth.instance;
  bool _initialized = false;
  GoogleSignInAccount? googleUser;

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        String text = _econtroller.text;
        print('Saved Latest: $text');
        _username = _usernameController.text;
        // adduserdetails(_username, _econtroller.text);
      });
    }
  }

  String? _textValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter some text";
    }
    if (value.trim().isEmpty) {
      return "Field left blank with white space";
    }
    if (value.contains("@")) {
      return "Do not use @";
    }
    if (value.isEmpty) {
      return "Please enter your password";
    }
    return null;
  }

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _initialized = true;
    if (kDebugMode) {
      print("Initialized default Firebase app $app");
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    if (!_initialized) {
      await initializeDefault();
    }
    // Trigger the authentication flow
    googleUser = await GoogleSignIn().signIn();

     setState(() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));  
    });

    if (kDebugMode) {
      print(googleUser!.displayName);
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
    // notifylisteners();
  }

  Future savinguserdetails(String firstName, String email) async{
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'email': email,
    });
  }

  @override
  void initState() {
    super.initState();
    // initializeDefault();
    password = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          height: 600.0,
          width: 600.0,
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: getBodyWidgetList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getBodyWidgetList() {
    return <Widget>[
      Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(11),
                alignment: Alignment.topLeft,
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(9),
                child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('Name:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    )),
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    hintText: "Enter Your Name",
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(9),
                child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('E-mail:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    )),
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: _econtroller,
                  validator: (String? value) {
                    if (value != null &&
                        (value.contains('@gmail.com') ||
                            value.contains('@outlook.com'))) {
                      if (value.contains(',')) {
                        return 'invalid email id';
                      } else {
                        return null;
                      }
                    } else {
                      return (value != null &&
                              (!value.contains('@gmail.com') ||
                                  !value.contains('@outlook.com')))
                          ? 'invalid email id'
                          : null;
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    hintText: "Enter email id",
                  ),
                ),
              ),
              const Text(" "),
              Container(
                margin: const EdgeInsets.all(9),
                child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('Password:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    )),
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: _pcontroller,
                  validator: _textValidator,
                  obscureText: password,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    hintText: "Enter password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        password ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          password = !password;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const Text(" "),
              ElevatedButton(
                child:
                    const Text('Signup', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  _email = _econtroller.text;
                  _password = _pcontroller.text;
                  _username = _usernameController.text;
                  try {
                    await auth.createUserWithEmailAndPassword(email: _email, password: _password);
                    await FirebaseAuth.instance.currentUser!.updateDisplayName(_username);
                    savinguserdetails(_usernameController.text,_econtroller.text);
                    setState(() {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const HomePage(); // Default to FirstRoute if the route is unknown.
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const Offset begin = Offset(0.0, 0.0);
                            const Offset end = Offset(0.0, 0.0);
                            // const Offset end = Offset(0.0,0.0);
                            const Curve curve = Curves.ease;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    });
                    _usernameController.clear();
                    _econtroller.clear();
                    _pcontroller.clear();
                  } catch (e) {
                    if (e is FirebaseAuthException) {
                      if (e.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Email already in use'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (e.code == 'invalid-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Password should be at least 6 characters'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                    print('Error creating user: $e');
                  }
                },
              ),
              const Text(" "),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 0.5, color: Colors.grey),
                    ),
                    Text('Or continue With'),
                    Expanded(
                      child: Divider(thickness: 0.5, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Text(" "),
              IconButton(
                icon: Image.asset('assets/google.png'),
                iconSize: 40,
                onPressed: () {
                 signInWithGoogle();
                  // adduserdetails(_usernameController.text.trim(),_econtroller.text.trim());
                },
              ),
            ],
          ),
        ),
      ),
      // const Text('Already User? SignIn Here',Navigator.pushNamed(context, login())),
      // const Text('Already User? SignIn Here',style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.bold)),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const login(); // Default to FirstRoute if the route is unknown.
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const Offset begin = Offset(0.0, 0.0);
                const Offset end = Offset(0.0, 0.0);
                // const Offset end = Offset(0.0,0.0);
                const Curve curve = Curves.ease;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        },
        child: const Text(
          'Already User? SignIn Here',
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold),
        ),
      ),
    ];
  }
}
