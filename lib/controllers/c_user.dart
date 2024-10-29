import 'dart:convert';

import 'package:gsfa/views/Services/get_scolarite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/api.dart';
import '../models/user.dart';
import '../views/Services/get_cantine.dart';
import '../widgets/event_pref.dart';
import 'package:http/http.dart' as http;

import '../widgets/info_message.dart';

class CUser extends GetxController {
  Rx<User> _user = User(0, '', '', '', '', '').obs;

  User get user => _user.value;

  void getUser() async {
    User? user = await EventPref.getUser();
    _user.value = user!;
  }

  Future<int?> checkStatus(BuildContext context) async {
    try {
      var response = await http.post(
        Uri.parse(Api.checkStatus),
        body: {
          'id_user': user.id_user.toString()
        }, // Correctly send the body as a map
      );
      if (response.statusCode == 200) {
        print(response.body);

        var responseBody = jsonDecode(response.body);
        print(responseBody['status']);
        return int.parse(responseBody['status']);
      } else {
        InfoMessage.snackbar(context, 'Échec de la connexion');
      }
    } catch (e) {
      print(e);
      InfoMessage.snackbar(context, 'Une erreur s\'est produite');
    }
    return null;
  }

  void showModal1(BuildContext context, data) {
    showModalBottomSheet(
      // showDragHandle: true,
      // context: context,
      // isScrollControlled: true,
      showDragHandle: true,
      enableDrag: false,
      isDismissible: false,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Scaffold(
            floatingActionButton: Column(
              children: [
                Expanded(child: Container()), // Espace extensible
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => GetScolarite(data: data),
                            fullscreenDialog: true);
                        // Get.off(() => ModeSubscription(
                        //       data: const {},
                        //       montant: 9900,
                        //       echeancier: 'Abonnement',
                        //     ));
                      },
                      style: ButtonStyle(
                          fixedSize: WidgetStateProperty.all(
                            Size(MediaQuery.of(context).size.width, 45),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all<Color>(
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                          )),
                      child: Text(
                        "Continuer",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.02,
                  ),
                  Image(
                    image: const AssetImage("assets/images/logo.png"),
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Offre Spéciale',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "durant toute l'année scolaire 2024-2025",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                      elevation: 8,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          // style: ListTileStyle(),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Forfait annuel',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    // SizedBox(height: 50,),
                                    Container(
                                        decoration: BoxDecoration(
                                            // border: Border.all(color: Colors.red),
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            'Economisez 37%',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.025,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "2.000 F CFA par an",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // subtitle: Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          //   child: Text(
                          //     'Total: 13.500 F CFA par an',
                          //     style: Theme.of(context).textTheme.bodySmall,
                          //   ),
                          // ),
                          trailing: Icon(
                            Icons.check_circle_outline_outlined,
                            size: 50,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Column(
                      children: [
                        const Text(
                          "Bénéficiez d'avantages exclusifs :",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        RichText(
                          textAlign: TextAlign.left,
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: '     • Transactions à 1% ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              TextSpan(
                                  text:
                                      'via Wave et Orange Money (au lieu de 3%).',
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: '     • Devoirs de maison gratuits ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              TextSpan(
                                  text: 'à télécharger pour vos enfants.',
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        // Text(
                        //     'Transactions à 1% via Wave et Orange Money (au lieu de 3%)'),
                        // Text(
                        //     'Devoirs de maison gratuits à télécharger pour vos enfants)'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showModal2(BuildContext context, data) {
    showModalBottomSheet(
      // showDragHandle: true,
      // context: context,
      // isScrollControlled: true,
      showDragHandle: true,
      enableDrag: false,
      isDismissible: false,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: Scaffold(
            floatingActionButton: Column(
              children: [
                Expanded(child: Container()), // Espace extensible
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => GetCantine(data: data),
                            fullscreenDialog: true);
                        // Get.off(() => ModeSubscription(
                        //       data: const {},
                        //       montant: 9900,
                        //       echeancier: 'Abonnement',
                        //     ));
                      },
                      style: ButtonStyle(
                          fixedSize: WidgetStateProperty.all(
                            Size(MediaQuery.of(context).size.width, 45),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all<Color>(
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                          )),
                      child: Text(
                        "Continuer",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.02,
                  ),
                  Image(
                    image: const AssetImage("assets/images/logo.png"),
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Offre Spéciale',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "durant toute l'année scolaire 2024-2025",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                      elevation: 8,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          // style: ListTileStyle(),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Forfait annuel',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    // SizedBox(height: 50,),
                                    Container(
                                        decoration: BoxDecoration(
                                            // border: Border.all(color: Colors.red),
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            'Economisez 37%',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.025,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "2.000 F CFA par an",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // subtitle: Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          //   child: Text(
                          //     'Total: 13.500 F CFA par an',
                          //     style: Theme.of(context).textTheme.bodySmall,
                          //   ),
                          // ),
                          trailing: Icon(
                            Icons.check_circle_outline_outlined,
                            size: 50,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Column(
                      children: [
                        const Text(
                          "Bénéficiez d'avantages exclusifs :",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        RichText(
                          textAlign: TextAlign.left,
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: '     • Transactions à 1% ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              TextSpan(
                                  text:
                                      'via Wave et Orange Money (au lieu de 3%).',
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: '     • Devoirs de maison gratuits ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              TextSpan(
                                  text: 'à télécharger pour vos enfants.',
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        // Text(
                        //     'Transactions à 1% via Wave et Orange Money (au lieu de 3%)'),
                        // Text(
                        //     'Devoirs de maison gratuits à télécharger pour vos enfants)'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
