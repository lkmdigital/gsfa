import 'dart:convert';
import 'package:gsfa/views/school_choice.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import '../../api/api.dart';
import '../../constantes/constantes.dart';
import '../../models/user.dart';
import '../first_page.dart';
import '../mot_de_passe_oublier/ForgetPassword.dart';
import '../../widgets/event_pref.dart';
import '../../widgets/info_message.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPhone = false;
  bool isPassword = false;
  bool isObscurityText = true;
  bool isLoading = false;

  void _onSubmit() {
    setState(() => isLoading = true);
    Future.delayed(
      const Duration(seconds: 2),
      () => setState(() {
        // isLoading = false;
        login();
      }),
    );
  }

  final _formKey = GlobalKey<FormState>();

  void login() async {
    try {
      var response = await http.post(
        Uri.parse(Api.login),
        body: {
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          InfoMessage.snackbar(Get.context!, 'Connecté(e)');
          User user = User.fromJson(responseBody['data']);
          await EventPref.saveUser(user);
          // Future.delayed(Duration(milliseconds: 1500), () {
          Get.offAll(() => const FirstPage());
          // });
        } else {
          // ignore: use_build_context_synchronously
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Erreur',
            text: 'Email ou mot de passe incorrect(s)',
          );
          setState(() {
            isLoading = false;
          });
        }
        print(responseBody['data']);
      } else {
        InfoMessage.snackbar(Get.context!, 'Echec de la connexion');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: Colors.white,
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Text(
                      "GS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 180, 34, 5),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    // width: width * 0.90,
                    child: Text(
                      "FA",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 224, 184, 4),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    // width: width * 0.90,
                    child: Text(
                      "-PAIE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255,94,66,18),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: AutoSizeText(
                      "Votre application de paiement \ndes frais d'écolage",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: 'Raleway'),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Ex: email@email.com',
                    hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 94, 3)), // Couleur du placeholder en bleu
                    prefixIcon: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                      child: Icon(
                        Icons.email_outlined,
                      ),
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(color: const Color.fromARGB(255, 116, 80, 2)),
                    // fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(style: BorderStyle.solid, color: Colors.green),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        // width: 1,
                        color: Couleurs.ButtonCouleur,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre adresse email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: isObscurityText,
                  decoration: InputDecoration(
                    hintText: "Ex: ******",
                    hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 94, 3)), // Couleur du placeholder en bleu
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Icon(
                        Icons.lock,
                        // color: Couleurs.ButtonCouleur,
                      ),
                    ),
                    suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscurityText = !isObscurityText;
                            });
                          },
                          icon: Visibility(
                            visible: isObscurityText,
                            replacement: const Icon(
                              Icons.visibility_off,
                              // color: Couleurs.ButtonCouleur,
                            ),
                            child: const Icon(
                              Icons.remove_red_eye_outlined,
                              // color: Couleurs.ButtonCouleur,
                            ),
                          ),
                        )),
                    labelText: "Mot de passe",
                    labelStyle: TextStyle(color: const Color.fromARGB(255, 116, 80, 2)),
                    // fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(style: BorderStyle.solid)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          // color: Couleurs.ButtonCouleur,
                          ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre mot de passe';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(() => const ForgetPasswordPage());
                      },
                      child: const AutoSizeText(
                        "Mot de passe oublié ?",
                        style: TextStyle(
                          fontSize: 14.0,
                          // color: Couleurs.ButtonCouleur,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                       color: const Color.fromARGB(255,94,66,18), // Couleur bleue en fond
                    borderRadius: BorderRadius.circular(15.0),
                    border: const Border.fromBorderSide(BorderSide.none),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        isLoading ? null : _onSubmit();
                      }
                    },
                    child: isLoading
                        ? Center(
                            child: Container(
                              width: size.width * 0.06,
                              height: size.height * 0.03,
                              padding: const EdgeInsets.all(2.0),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            ),
                          )
                        : const Center(
                            child: AutoSizeText(
                              "CONNEXION",
                              style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AutoSizeText(
                      "Vous n'avez pas de compte ?",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                      minFontSize: 13,
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const Register());
                      },
                      child: const AutoSizeText(
                        "Inscription",
                        textAlign: TextAlign.center,
                        minFontSize: 13,
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Image(
                  image: const AssetImage("assets/images/logo.png"),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
