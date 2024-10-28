import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../api/api.dart';
import '../class/student.dart';
import '../constantes/constantes.dart';
import '../controllers/c_user.dart';
import '../widgets/event_pref.dart';
import 'login/login.dart';
import 'operations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;

class Accueil extends StatefulWidget {
  const Accueil({super.key, this.schoolid});
  final String? schoolid;

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  TextEditingController _naissanceController = TextEditingController();
  TextEditingController _matriculeController = TextEditingController();
  bool isDate = false;
  final CUser _cUser = Get.find();

  final _formKey = GlobalKey<FormState>();

  void setBirthday() async {
    DateTime? date = DateTime(1900);
    FocusScope.of(context).requestFocus(
      FocusNode(),
    );
    date = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: "ENTREZ UNE DATE",
      errorFormatText: "Format invalide essayez avec: xx/xx/xxxx",
      errorInvalidText: "",
      fieldHintText: "xx/xx/xxxx",
      fieldLabelText: "Entrez la date de naissance",
    );
    if (date != null) {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String dateFormatted = formatter.format(date);
      setState(() {
        _naissanceController.text = dateFormatted;
        isDate = true;
      });
    }
  }

  void logout() async {
    // apres deconnexion
    var response = await Get.dialog(
      AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Vous êtes sur le point de vous déconnecter'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Annuler')),
          TextButton(
              onPressed: () => Get.back(result: 'Déconnexion'),
              child: const Text('Déconnexion')),
        ],
      ),
    );
    if (response == 'Déconnexion') {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      Future.delayed(const Duration(milliseconds: 1500), () {
        EventPref.deleteUser().then((value) {
          Get.offAll(() => const Login());
        });
      });
    }
  }

  void valider({required TextEditingController matricule}) async {
    Get.to(() => Operation(
          schoolid: '${widget.schoolid}',
          data: {},
        ));
  }

  Future<void> getLocalVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String localVersion = packageInfo.version;
    print(localVersion);
    String apiVersion = await getVersionFromAPI();

    // Compare les versions
    if (apiVersion.compareTo(localVersion) > 0) {
      // La version de l'API est supérieure à la version locale
      _showModal(context);
    }
  }

  Future<String> getVersionFromAPI() async {
    try {
      final response = await http.get(Uri.parse(Api.checkAppVersion));
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        print(data['version']);
        return data['version'];
      } else {
        throw Exception(
            'Erreur lors de la récupération de la version de l\'application.');
      }
    } catch (e) {
      throw Exception(
          'Erreur lors de la récupération de la version de l\'application: $e');
    }
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Get.off(() => const AwaitWebhook());
                  var androidUrl = Uri.parse(
                      'https://play.google.com/store/apps/details?id=com.lkmdigital.coccinelle_pay');
                  var iosUrl = Uri.parse(
                      'https://apps.apple.com/us/app/coccinelle-pay/id6451042354?l=fr-FR');

                  if (Platform.isAndroid) {
                    launchUrl(androidUrl);
                  } else if (Platform.isIOS) {
                    launchUrl(iosUrl);
                  } else {
                    throw UnsupportedError('This platform is not supported');
                  }

                  // launchUrl(
                  //   url,
                  //   mode: LaunchMode.externalApplication,
                  // );
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
                  "Mettre à jour",
                  style: TextStyle(
                      fontSize: 18,
                      color:
                          Theme.of(context).buttonTheme.colorScheme!.onPrimary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: SingleChildScrollView(
              child: Center(
                  child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.02,
                  ),
                  Image(
                    image: const AssetImage("assets/images/logo.png"),
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: AutoSizeText(
                      'Une nouvelle version de l\'application est disponible !',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      minFontSize: 23,
                      maxFontSize: 25,
                      // style: GoogleFonts.kaushanScript(fontSize: 25),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'Veuillez mettre à jour l\'application pour bénéficier des dernières fonctionnalités et améliorations.\n',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,

                      // style:
                      //     GoogleFonts.kaushanScript(fontSize: 25, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'Cliquez sur le bouton "Mettre à jour" pour télécharger la nouvelle version depuis le magasin d\'applications.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,

                      // style:
                      //     GoogleFonts.kaushanScript(fontSize: 25, color: Colors.blue),
                    ),
                  ),
                ],
              )),
            ),
          ),
        );
      },
    );
  }


  
  String logoName(String schoolName) {
  switch (schoolName) {
    case "fama":
      return "fama"; // le fichier serait assets/images/fama.png
    case "fatyma2":
      return "fatyma2"; // le fichier serait assets/images/fatyma.png
    // Ajoute d'autres écoles ici
    default:
      return "logo"; // Un logo par défaut si l'école n'est pas reconnue
  }
}

  @override
  void initState() {
    super.initState();
    getLocalVersion();
  }

  Future<List<Student>> getSchoolChildren() async {
    print("ecole ${widget.schoolid}");
    List<Student> listChildren = [];
    var response = await http.post(
      Uri.parse(Api.getChildren),
      body: {
        'telephone': _cUser.user.telephone.toString(),
        'school': widget.schoolid.toString(),
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      var responseBody = jsonDecode(response.body);
      // inspect(responseBody);
      if (responseBody['success']) {
        for (var element in (responseBody['data'] as List)) {
          listChildren.add(Student.fromJson(element));
        }
      }
    }
    return listChildren;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: const AutoSizeText(
          "GSFA PAY",
          maxFontSize: 16,
          minFontSize: 11,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // backgroundColor: Couleurs.CouleurSecondaire,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              size: 35,
            ),
            onPressed: () {
              // logout();
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
                    image: AssetImage(
                        "assets/images/${logoName(widget.schoolid.toString())}.png"),
                    width: width * 0.9,
                    height: height * 0.15,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Center(
                    child: AutoSizeText(
                      "Liste des enfants",
                      textAlign: TextAlign.center,
                      style: Theme.of(this.context).textTheme.displayMedium,
                      maxFontSize: 20,
                      minFontSize: 12,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  buildAll(),
        ],
      ),
    );
  }

  Widget buildAll() {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: getSchoolChildren(),
      builder: (context, AsyncSnapshot<List<Student>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
              //Chargement shimmer
              baseColor: const Color.fromARGB(255, 212, 208, 208),
              highlightColor: const Color.fromARGB(255, 253, 250, 250),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            // height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            // height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            // height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            // height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            // height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            // height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ));
        }
        if (snapshot.data == null) {
          return const Center(child: Text('Echec de la connexion'));
        }
        if (snapshot.data!.isNotEmpty) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.amber,
                  height: MediaQuery.of(context).size.height * 0.50,
                  padding: const EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    // scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Student student = snapshot.data![index];

                      return SizedBox(
                        width: width * 0.98,
                        height: height * 0.12,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    var childrenData = {
                                      "nom": student.nom,
                                      "prenom": student.prenom,
                                      "matricule": student.matricule,
                                      "telephone": student.telephone,
                                      "classe": student.classe,
                                      "date_naissance": student.date_naissance,
                                    };
                                    Get.to(() => Operation(
                                          data: childrenData,
                                          schoolid: '${widget.schoolid}',
                                        ));
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 1.0,
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(17))),
                                      child: ListTile(
                                        leading: const CircleAvatar(
                                          child: Icon(
                                            Icons.person,
                                            size: 17,
                                            // color: Colors.white,
                                          ),
                                        ),
                                        title: Text(
                                          "${student.nom} ${student.prenom}",
                                          style: Theme.of(this.context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        trailing:
                                            const Icon(Icons.chevron_right),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Aucun enfant trouvé'));
        }
      },
    );
  }
}
