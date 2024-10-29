import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../widgets/info_message.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../api/api.dart';
import '../../constantes/constantes.dart';
import '../../controllers/c_user.dart';
import 'mtn_webhook.dart';

class PaiementPage extends StatefulWidget {
  Map data;
  final frais;
  final String mode;
  final eliah;
  final String frais_eliah;
  final tel;
  final montant;
  final echeancier;

  PaiementPage(
      {Key? key,
      required this.data,
      required this.frais,
      required this.mode,
      required this.eliah,
      required this.frais_eliah,
      required this.tel,
      required this.montant,
      required this.echeancier})
      : super(key: key);
  @override
  _PaiementPage createState() => _PaiementPage();
}

class _PaiementPage extends State<PaiementPage> {
  final _cUser = Get.put(CUser());
  bool isLoading = false;

  bool isCheked = false;

  Color? color;
  IconData? icon;
  bool show = false;

  @override
  Widget build(BuildContext context) {
    var v = widget.montant.toString();
    var v1 = v.replaceAll(RegExp(r"\s+"), "");
    var v2 = int.parse(v1);

    Future paywave() async {
      var fraisAbonnement = widget.data['status'] == 0 ? 2000 : 0;
      // print(widget.frais + widget.eliah + v2);
      try {
        var response = await http.post(
          Uri.parse(Api.pay),
          body: {
            'id_user': '${_cUser.user.id_user}',
            'nom_parent': '${_cUser.user.nom} ${_cUser.user.prenom}',
            'telephone': (widget.tel.toString().isEmpty)
                ? _cUser.user.telephone
                : widget.tel.toString(),
            'email': _cUser.user.email,
            'schoolid': "${widget.data['schoolid']}",
            'eleve': (widget.data['prenom'] == null)
                ? '${widget.data['nom']} ${widget.data['prenom']}'
                : '${widget.data['nom']} ${widget.data['prenom']}',
            'nom_eleve': '${widget.data['nom']}',
            'prenom_eleve': (widget.data['prenom'] == null)
                ? '${widget.data['prenom']}'
                : '${widget.data['prenom']}',
            'date_naissance': '${widget.data['date_naissance']}',
            'lieu_naissance': (widget.data['lieu'] == null)
                ? "${widget.data['classe']}"
                : '${widget.data['lieu']}',
            'classe': '${widget.data['classe']}',
            'ecole': '${widget.data['schoolid']}',
            'matricule': '${widget.data['matricule']}',
            'mode_paiement': widget.mode.toUpperCase(),
            'montant_initial': v1,
            'frais_operateur': '${widget.frais}',
            'frais_eliah': '${widget.eliah}',
            'montant': '${fraisAbonnement + widget.eliah + v2 + widget.frais}',
            'type': '${widget.data['service']}',
            'echeancier': "${widget.echeancier}".toString(),
            'abonnement': fraisAbonnement.toString(),
          },
        );

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          Uri url = Uri.parse(responseBody);
          print(url);
          if (!await launchUrl(
            url,
            mode: LaunchMode.externalApplication,
          )) {
            throw 'Could not launch $url';
          }
        } else {
          InfoMessage.snackbar(Get.context!, 'Echec de la connexion');
        }
      } catch (e) {
        print(e);
      }
      setState(() {
        isLoading = false;
      });
    }

    Future orange() async {
      var fraisAbonnement = widget.data['status'] == 0 ? 2000 : 0;
      try {
        var response = await http.post(
          Uri.parse(Api.pay),
          body: {
            'id_user': '${_cUser.user.id_user}',
            'nom_parent': '${_cUser.user.nom} ${_cUser.user.prenom}',
            'telephone': (widget.tel.toString().isEmpty)
                ? _cUser.user.telephone
                : widget.tel.toString(),
            'email': _cUser.user.email,
            'schoolid': "${widget.data['schoolid']}",
            'eleve': (widget.data['prenom'] == null)
                ? '${widget.data['nom']} ${widget.data['prenom']}'
                : '${widget.data['nom']} ${widget.data['prenom']}',
            'nom_eleve': '${widget.data['nom']}',
            'prenom_eleve': (widget.data['prenom'] == null)
                ? '${widget.data['prenom']}'
                : '${widget.data['prenom']}',
            'date_naissance': '${widget.data['date_naissance']}',
            'lieu_naissance': (widget.data['lieu'] == null)
                ? "${widget.data['classe']}"
                : '${widget.data['lieu']}',
            'classe': '${widget.data['classe']}',
            'ecole': '${widget.data['schoolid']}',
            'matricule': '${widget.data['matricule']}',
            'mode_paiement': widget.mode.toUpperCase(),
            'montant_initial': v1,
            'frais_operateur': '${widget.frais}',
            'frais_eliah': '${widget.eliah}',
            'montant': '${fraisAbonnement + widget.eliah + v2 + widget.frais}',
            'type': '${widget.data['service']}',
            'echeancier': "${widget.echeancier}".toString(),
            'abonnement': fraisAbonnement.toString(),
          },
        );
        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          Uri url = Uri.parse(responseBody);
          if (!await launchUrl(
            url,
            mode: LaunchMode.externalApplication,
          )) {
            throw 'Could not launch $url';
          }
        } else {
          InfoMessage.snackbar(Get.context!, 'Echec de la connexion');
        }
      } catch (e) {
        print(e);
      }
      setState(() {
        isLoading = false;
      });
    }

    Future paymtn() async {
      var fraisAbonnement = widget.data['status'] == 0 ? 2000 : 0;
      // print(widget.frais + widget.eliah + v2);
      try {
        var response = await http.post(
          Uri.parse(Api.pay),
          body: {
            'id_user': '${_cUser.user.id_user}',
            'nom_parent': '${_cUser.user.nom} ${_cUser.user.prenom}',
            'telephone': (widget.tel.toString().isEmpty)
                ? _cUser.user.telephone
                : widget.tel.toString(),
            'email': _cUser.user.email,
            'schoolid': "${widget.data['schoolid']}",
            'eleve': (widget.data['prenom'] == null)
                ? '${widget.data['nom']} ${widget.data['prenom']}'
                : '${widget.data['nom']} ${widget.data['prenom']}',
            'nom_eleve': '${widget.data['nom']}',
            'prenom_eleve': (widget.data['prenom'] == null)
                ? '${widget.data['prenom']}'
                : '${widget.data['prenom']}',
            'date_naissance': '${widget.data['date_naissance']}',
            'lieu_naissance': (widget.data['lieu'] == null)
                ? "${widget.data['classe']}"
                : '${widget.data['lieu']}',
            'classe': '${widget.data['classe']}',
            'ecole': '${widget.data['schoolid']}',
            'matricule': '${widget.data['matricule']}',
            'mode_paiement': widget.mode.toUpperCase(),
            'montant_initial': v1,
            'frais_operateur': '${widget.frais}',
            'frais_eliah': '${widget.eliah}',
            // 'montant': '100',
            'montant': '${fraisAbonnement + widget.eliah + v2}',

            'type': '${widget.data['service']}',
            'echeancier': "${widget.echeancier}".toString(),
            'abonnement': fraisAbonnement.toString(),
          },
        );

        if (response.statusCode == 200) {
          Get.to(() => const AwaitWebhook(), fullscreenDialog: true);
        } else {
          InfoMessage.snackbar(Get.context!, 'Echec de la connexion');
        }
      } catch (e) {
        print(e);
      }
      setState(() {
        isLoading = false;
      });
    }

    Future payVisa() async {
      var fraisAbonnement = widget.data['status'] == 0 ? 2000 : 0;
      try {
        var response = await http.post(
          Uri.parse(
            Api.pay,
          ),
          body: {
            'id_user': '${_cUser.user.id_user}',
            'nom_parent': '${_cUser.user.nom} ${_cUser.user.prenom}',
            'telephone': (widget.tel.toString().isEmpty)
                ? _cUser.user.telephone
                : widget.tel.toString(),
            'email': _cUser.user.email,
            'schoolid': "${widget.data['schoolid']}",
            'eleve': (widget.data['prenom'] == null)
                ? '${widget.data['nom']} ${widget.data['prenom']}'
                : '${widget.data['nom']} ${widget.data['prenom']}',
            'nom_eleve': '${widget.data['nom']}',
            'prenom_eleve': (widget.data['prenom'] == null)
                ? '${widget.data['prenom']}'
                : '${widget.data['prenom']}',
            'date_naissance': '${widget.data['date_naissance']}',
            'lieu_naissance': (widget.data['lieu'] == null)
                ? "${widget.data['classe']}"
                : '${widget.data['lieu']}',
            'classe': '${widget.data['classe']}',
            'matricule': '${widget.data['matricule']}',
            // 'mode_paiement': 'CARD',
            'mode_paiement': widget.mode.toUpperCase(),
            'montant_initial': v1,
            'frais_operateur': '${widget.frais}',
            'frais_eliah': '${widget.eliah}',
            'montant': '${fraisAbonnement + widget.eliah + v2 }',
            'type': '${widget.data['service']}',
            'echeancier': "${widget.echeancier}".toString(),
            'abonnement': fraisAbonnement.toString(),
          },
        );

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          print(responseBody);

          Uri url = Uri.parse(responseBody);
          if (!await launchUrl(url,
              mode: LaunchMode.externalApplication,
              webViewConfiguration: const WebViewConfiguration())) {
            throw 'Could not launch $url';
          }
        } else {
          InfoMessage.snackbar(Get.context!, 'Echec de la connexion');
        }
      } catch (e) {
        print(e);
      }
      setState(() {
        isLoading = false;
      });
    }

    void paymentMode() {
      switch (widget.mode) {
        case "WAVECI":
          {
            paywave();
            print("WAVE");
          }
          break;

        case "OMCI":
          {
            orange();

            print("OMCI");
          }
          break;

        case "MTNCI":
          {
            paymtn();
            print("MTN");
          }
          break;

        default:
          {
            // print("Default");
            payVisa();
          }
          break;
      }
    }

    void onSubmit() {
      setState(() => isLoading = true);
      Future.delayed(
        const Duration(seconds: 2),
        () => setState(() {
          paymentMode();
          // paywave();
          // payorange();
        }),
      );
    }

    Size size = MediaQuery.of(context).size;
    NumberFormat myFormat = NumberFormat.decimalPattern('eu');
    var fraisAbonnement = widget.data['status'] == 0 ? 2000 : 0;
    var total = fraisAbonnement + widget.eliah + v2 + widget.frais;
    Color cTA = Theme.of(context).buttonTheme.colorScheme!.primaryContainer;

    return GetBuilder(
      init: CUser(),
      builder: (context) {
        return Scaffold(
          floatingActionButton: Container(
              height: size.height * 0.055,
              width: Get.width * 0.9,
              decoration: BoxDecoration(
                color: isCheked ? cTA : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20.0),
                border: const Border.fromBorderSide(BorderSide.none),
              ),
              child: InkWell(
                  onTap: isCheked
                      ? () {
                          isLoading ? null : onSubmit();
                        }
                      : null,
                  child: isLoading
                      ? Center(
                          child: Container(
                            width: Get.width * 0.06,
                            height: size.height * 0.03,
                            padding: const EdgeInsets.all(2.0),
                            child: const CircularProgressIndicator(
                              color:  Color.fromARGB(255, 127, 68, 4),
                              strokeWidth: 3,
                            ),
                          ),
                        )
                      : Center(
                          child: AutoSizeText(
                            "Passer au paiement",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: isCheked ? const Color.fromARGB(255, 127, 68, 4) : const Color.fromARGB(255, 127, 68, 4),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Détails de la transaction"),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(
                left: Dimensions.MobileMargin - 10,
                right: Dimensions.MobileMargin - 10,
              ),
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //ecole
                  Card(
                    elevation: 5,
                    child: Container(
                      width: size.width,
                      margin: const EdgeInsets.only(
                        bottom: Dimensions.MobileMargin - 10,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.MobileMargin,
                        vertical: Dimensions.MobileMargin - 10,
                      ),
                      decoration: const BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                            height: size.height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AutoSizeText(
                                "NOM:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey,
                                ),
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              AutoSizeText(
                                "${widget.data['nom']}",
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
                            height: size.height * 0.015,
                          ),
                          widget.data['prenoms'] == null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const AutoSizeText(
                                      "PRÉNOM(S):",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        // color: Colors.grey,
                                      ),
                                      minFontSize: 10,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    AutoSizeText(
                                      "${widget.data['prenom']}",
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
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const AutoSizeText(
                                      "PRÉNOM(S):",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        // color: Colors.grey,
                                      ),
                                      minFontSize: 10,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    AutoSizeText(
                                      "${widget.data['prenoms']}",
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
                            height: size.height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AutoSizeText(
                                "DATE DE NAISSANCE:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey,
                                ),
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              AutoSizeText(
                                "${widget.data['date_naissance']}",
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
                            height: size.height * 0.015,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     const AutoSizeText(
                          //       "LIEU DE NAISSANCE:",
                          //       style: TextStyle(
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.normal,
                          //         // color: Colors.grey,
                          //       ),
                          //       minFontSize: 10,
                          //       maxLines: 1,
                          //       overflow: TextOverflow.ellipsis,
                          //     ),
                          //     widget.data['lieu'] == null
                          //         ? AutoSizeText(
                          //             "${widget.data['classe']}",
                          //             textAlign: TextAlign.center,
                          //             style: const TextStyle(
                          //               fontSize: 12,
                          //               fontWeight: FontWeight.w500,
                          //             ),
                          //             minFontSize: 8,
                          //             maxLines: 1,
                          //             overflow: TextOverflow.ellipsis,
                          //           )
                          //         : AutoSizeText(
                          //             "${widget.data['lieu']}",
                          //             textAlign: TextAlign.center,
                          //             style: const TextStyle(
                          //               fontSize: 12,
                          //               fontWeight: FontWeight.w500,
                          //             ),
                          //             minFontSize: 8,
                          //             maxLines: 1,
                          //             overflow: TextOverflow.ellipsis,
                          //           ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: size.height * 0.02,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AutoSizeText(
                                "CLASSE:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey,
                                ),
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              AutoSizeText(
                                "${widget.data['classe']}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                minFontSize: 8,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          const AutoSizeText(
                            "PARENT",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              //
                            ),
                            minFontSize: 12,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AutoSizeText(
                                "NOM & PRENOM(S):",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey,
                                ),
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              AutoSizeText(
                                "${_cUser.user.nom} ${_cUser.user.prenom}",
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
                            height: size.height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AutoSizeText(
                                "EMAIL:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey,
                                ),
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              AutoSizeText(
                                _cUser.user.email,
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
                            height: size.height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AutoSizeText(
                                "TÉLÉPHONE:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey,
                                ),
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              widget.tel.toString() == ''
                                  ? AutoSizeText(
                                      _cUser.user.telephone,
                                      // widget.tel.toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                      minFontSize: 8,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : AutoSizeText(
                                      widget.tel.toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                      minFontSize: 8,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          const AutoSizeText(
                            "SERVICE",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              //
                            ),
                            minFontSize: 12,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AutoSizeText(
                                "TYPE:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey,
                                ),
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              AutoSizeText(
                                "${widget.data['service']}".toUpperCase(),
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
                            height: size.height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AutoSizeText(
                                "MONTANT INITIAL:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey,
                                ),
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              AutoSizeText(
                                "${widget.montant} F",
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
                            height: size.height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AutoSizeText(
                                "FRAIS TRANSACTION",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  // color: Colors.grey,
                                ),
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              AutoSizeText(
                                // '${totalfrais}',
                                // '$totalfrais F',
                                '${widget.eliah + widget.frais} F',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                minFontSize: 8,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          widget.data['status'] == 0
                              ? const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AutoSizeText(
                                      "FRAIS D'ABONNEMENT",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      minFontSize: 10,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    AutoSizeText(
                                      // '${totalfrais}',
                                      // '$totalfrais F',
                                      '2.000 F',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      minFontSize: 8,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AutoSizeText(
                                "TOTAL A PAYER:",
                                style: TextStyle(
                                  // color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              AutoSizeText(
                                // "${widget.frais + widget.eliah + v2} F",
                                '${myFormat.format(total)} F',
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

                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    value: isCheked,
                    activeColor: const Color.fromARGB(255, 127, 68, 4),
                    onChanged: (value) {
                      setState(() {
                        isCheked = value!;
                      });
                    },
                    title: Text(
                      "Cochez pour confirmer vos informations",
                      style: Theme.of(this.context).textTheme.titleSmall,
                    ),
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
