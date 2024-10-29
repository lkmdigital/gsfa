import 'dart:convert';
import 'package:gsfa/views/school_choice.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/api.dart';
import '../../constantes/constantes.dart';
import '../../controllers/c_user.dart';
import '../../models/autogenerated.dart';

class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  final _cUser = Get.put(CUser());

  Future<List<Autogenerated>> getPaiement() async {
    List<Autogenerated> listPaiement = [];
    var idUser = _cUser.user.id_user.toString();
    var response = await http.post(
      Uri.parse(Api.getLastPayment),
      body: {
        'id_user': idUser,
      },
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        for (var element in (responseBody['data'] as List)) {
          listPaiement.add(Autogenerated.fromJson(element));
        }
      }
    }
    return listPaiement;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return GetBuilder<CUser>(
      init: CUser(),
      builder: (context) {
        return Scaffold(
          floatingActionButton: Container(
            height: size.height * 0.055,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color: Theme.of(this.context)
                  .buttonTheme
                  .colorScheme!
                  .primaryContainer,
              borderRadius: BorderRadius.circular(20.0),
              border: const Border.fromBorderSide(BorderSide.none),
            ),
            child: InkWell(
              onTap: () {
                Get.offAll(() => const SchoolChoice());
              },
              child: const Center(
                child: AutoSizeText(
                  "Aller à l'accueil",
                  style:  TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1
                  ),
                  maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(
            title: const Text("PAIEMENT EFFECTUÉ", style: TextStyle(fontStyle: FontStyle.italic),),
            centerTitle: true,
            leading: Image(
              image: const AssetImage("assets/images/logo.png"),
              width: size.width,
              height: size.height,
            ),
            actions: const [
              Icon(
                size: 40,
                Icons.check_circle_outline,
                color: Colors.green,
              )
            ],
          ),
          body: buildAll(),
        );
      },
    );
  }

  Widget buildAll() {
    return FutureBuilder(
      future: getPaiement(),
      builder: (context, AsyncSnapshot<List<Autogenerated>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Theme.of(context).buttonTheme.colorScheme!.primaryContainer,
          ));
        }
        if (snapshot.data == null) {
          return const Center(child: Text('Echec de la connexion'));
        }
        if (snapshot.data!.isNotEmpty) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  // color: Colors.amber,
                  height: MediaQuery.of(context).size.height * 1,
                  child: ListView.builder(
                    // scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Autogenerated paiementdetails = snapshot.data![index];
                      return Container(
                        margin: const EdgeInsets.only(
                          left: Dimensions.MobileMargin - 10,
                          right: Dimensions.MobileMargin - 10,
                        ),
                        child: Stack(
                          children: [
                            Card(
                              elevation: 5,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(
                                  bottom: Dimensions.MobileMargin - 10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.MobileMargin,
                                  vertical: Dimensions.MobileMargin - 10,
                                ),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  // color: Colors.white
                                  // border: Border.all(
                                  //   color: Color.fromARGB(255, 129, 123, 123),
                                  //   width: 2,
                                  // ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const AutoSizeText(
                                      "ELEVE",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      minFontSize: 12,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const AutoSizeText(
                                          "NOM & PRENOM(S):",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        AutoSizeText(
                                          "${paiementdetails.nomEleve} ${paiementdetails.prenomEleve}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          minFontSize: 8,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const AutoSizeText(
                                          "DATE DE NAISSANCE:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        AutoSizeText(
                                          paiementdetails.dateNaissance,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          minFontSize: 8,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const AutoSizeText(
                                          "LIEU DE NAISSANCE:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        AutoSizeText(
                                          paiementdetails.lieuNaissance,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          minFontSize: 8,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const AutoSizeText(
                                          "CLASSE:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        AutoSizeText(
                                          paiementdetails.classe,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          minFontSize: 8,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Divider(
                                      thickness: 1,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const AutoSizeText(
                                      "PARENT",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      minFontSize: 12,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const AutoSizeText(
                                          "NOM & PRENOM(S):",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        AutoSizeText(
                                          paiementdetails.nomParent,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          minFontSize: 8,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const AutoSizeText(
                                          "EMAIL:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        AutoSizeText(
                                          paiementdetails.email,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          minFontSize: 8,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Divider(
                                      thickness: 1,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const AutoSizeText(
                                      "SERVICE",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      minFontSize: 12,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const AutoSizeText(
                                          "TYPE:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        AutoSizeText(
                                          paiementdetails.type.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          minFontSize: 8,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const AutoSizeText(
                                          "MONTANT INITIAL:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        AutoSizeText(
                                          "${paiementdetails.montantInitial} F",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          minFontSize: 8,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const AutoSizeText(
                                          "FRAIS TRANSACTION",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        AutoSizeText(
                                          '${(int.parse(paiementdetails.fraisOperateur) + int.parse(paiementdetails.fraisEliah))} F',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          minFontSize: 8,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const AutoSizeText(
                                          "TOTAL PAYE:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        AutoSizeText(
                                          "${paiementdetails.montant} F",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          minFontSize: 8,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const AutoSizeText(
                                          "DATE TRANSACTION:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        AutoSizeText(
                                          paiementdetails.dateTransaction,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          minFontSize: 8,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const AutoSizeText(
                                          "REFERENCE:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        AutoSizeText(
                                          paiementdetails.reference,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          minFontSize: 8,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              // top: 40,
                              bottom: MediaQuery.sizeOf(context).height * 0.01,
                              right: MediaQuery.sizeOf(context).width * 0.2,
                              child: Transform.rotate(
                                angle: -30 * 0.0174533,
                                child: Opacity(
                                  opacity: 0.6,
                                  child: Image(
                                    // color: Colors.blueGrey,
                                    image: const AssetImage(
                                        "assets/images/paid.png"),
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.5,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                )
              ],
            ),
          );
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }
}
