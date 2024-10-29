import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import '../constantes/constantes.dart';
import '../controllers/c_user.dart';
import '../widgets/root.dart';
import 'school_choice.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final CUser _cUser = Get.put(CUser());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder(
      init: CUser(),
      initState: (state) {
        _cUser.getUser();
      },
      builder: (controller) {
        return Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => const SchoolChoice());
              },
              style: ButtonStyle(
                fixedSize: WidgetStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 55),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(
                  const Color.fromARGB(255, 127, 68, 4),
                ), //verifier si la couleur est nul (si oui alors on lui donne la couleur pas defaut)
              ),
              child: Text(
                'Commencer',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // fontSize: 18,
                  color: Theme.of(context).buttonTheme.colorScheme!.onPrimary,
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(
            title: const Text("GSFA - Pay"),
            centerTitle: false,
            actions: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset("assets/images/logo.png"),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: size.height,
                      width: size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/eleve.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: size.height,
                      width: size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          stops: [0, 0.7],
                          colors: [
                            Colors.transparent, // Couleur avec opacité totale
                            Colors.black
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: size.height * 0.28),
                            child: const Column(
                              children: [
                                Text(
                                  "Bienvenue",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text(
                                    'Gérez désormais toute la scolarité de votre enfant avec cette application.',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
