import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constantes/constantes.dart';
import '../controllers/c_user.dart';
import 'Services/get_scolarite.dart';

class Operation extends StatefulWidget {
  final schoolid;
  final Map data;

  const Operation({super.key, required this.data, required this.schoolid});

  @override
  State<Operation> createState() => _OperationState();
}

class _OperationState extends State<Operation> {
  final CUser _cUser = Get.find();

  @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CUser(),
        builder: (context_) {
          return Scaffold(
              // backgroundColor: Colors.grey.shade100,
              appBar: AppBar(
                centerTitle: true,
                title: const AutoSizeText(
                  "SERVICES",
                  maxFontSize: 15,990
                  minFontSize: 14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              body: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 1.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: Dimensions.MobileMargin,
                          right: Dimensions.MobileMargin,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Center(
                                      child: AutoSizeText(
                                        "Nom:",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                23),
                                      ),
                                    ),
                                    Center(
                                      child: AutoSizeText(
                                        "${widget.data['nom']}",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                23),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Row(
                                  children: [
                                    Center(
                                      child: AutoSizeText(
                                        "Prénom(s):",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                23),
                                      ),
                                    ),
                                    Center(
                                      child: AutoSizeText(
                                        "${widget.data['prenom']}",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                23),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Row(
                                  children: [
                                    Center(
                                      child: AutoSizeText(
                                        "Classe: ",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                23),
                                      ),
                                    ),
                                    Center(
                                      child: AutoSizeText(
                                        " ${widget.data['classe']}",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                23),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Row(
                                  children: [
                                    Center(
                                      child: AutoSizeText(
                                        "Date de naissance: ",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                23),
                                      ),
                                    ),
                                    Center(
                                      child: AutoSizeText(
                                        " ${widget.data['date_naissance']}",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                23),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Row(
                                  children: [
                                    Center(
                                      child: AutoSizeText(
                                        "Matricule:",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                23),
                                      ),
                                    ),
                                    Center(
                                      child: AutoSizeText(
                                        " ${widget.data['matricule']}",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                23),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                          ],
                        ),
                      ),
                      // const Divider(
                      //   color: Colors.grey,
                      // ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(
                          left: Dimensions.MobileMargin - 10,
                          right: Dimensions.MobileMargin - 10,
                        ),
                        decoration: const BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        });
                                    var status =
                                        await _cUser.checkStatus(context);
                                    print(status);
                                    if (status != null) {
                                      if (status == 0) {
                                        Get.back();
                                        var data = {
                                          'nom': widget.data['nom'], //Map
                                          'prenom': widget.data['prenom'], //Map
                                          'classe': widget.data['classe'],
                                          'date_naissance':
                                              widget.data['date_naissance'],
                                          'matricule': widget.data['matricule'],
                                          'service': 'FRAIS SCOLAIRES',
                                          'status': status,
                                          'schoolid': widget.schoolid,
                                        };
                                        Get.back();

                                        _cUser.showModal1(context, data);
                                      } else {
                                        var data = {
                                          'nom': widget.data['nom'], //Map
                                          'prenom': widget.data['prenom'], //Map
                                          'classe': widget.data['classe'],
                                          'date_naissance':
                                              widget.data['date_naissance'],
                                          'matricule': widget.data['matricule'],
                                          'service': 'FRAIS SCOLAIRES',
                                          'status': status,
                                          'schoolid': widget.schoolid,
                                        };
                                        print(" status ${status}");
                                        Get.back();

                                        Get.to(() => GetScolarite(data: data),
                                            fullscreenDialog: true);
                                        // maintenance();
                                      }
                                    }
                                  },
                                  child: Card(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    elevation: 1,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Image.asset(
                                                  'assets/images/paiement_scolarite.png',
                                                  width: 50,
                                                  height: 50,
                                                ),
                                              ),
                                              Text(
                                                'FRAIS SCOLAIRES',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                                   GestureDetector(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        });
                                    var status =
                                        await _cUser.checkStatus(context);
                                    print(status);
                                    if (status != null) {
                                      if (status == 0) {
                                        Get.back();
                                        var data = {
                                          'nom': widget.data['nom'], //Map
                                          'prenom': widget.data['prenom'], //Map
                                          'classe': widget.data['classe'],
                                          'date_naissance':
                                              widget.data['date_naissance'],
                                          'matricule': widget.data['matricule'],
                                          'service': 'EXTRA SCOLAIRES',
                                          'status': status,
                                          'schoolid': widget.schoolid,
                                        };
                                        Get.back();

                                        _cUser.showModal2(context, data);
                                        // maintenance();
                                      } else {
                                        var data = {
                                          'nom': widget.data['nom'], //Map
                                          'prenom': widget.data['prenom'], //Map
                                          'classe': widget.data['classe'],
                                          'date_naissance':
                                              widget.data['date_naissance'],
                                          'matricule': widget.data['matricule'],
                                          'service': 'EXTRA SCOLAIRES',
                                          'status': status,
                                          'schoolid': widget.schoolid,
                                        };
                                        Get.back();

                                        Get.to(() => GetScolarite(data: data),
                                            fullscreenDialog: true);
                                        // maintenance();
                                      }
                                    }
                                  },
                                  child: Card(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    elevation: 1,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Image.asset(
                                                  'assets/images/sports.png',
                                                  width: 50,
                                                  height: 50,
                                                ),
                                              ),
                                              Text(
                                                'FRAIS EXTRA SCOLAIRES',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              // GestureDetector(
                              //     onTap: () async {
                              //       showDialog(
                              //           context: context,
                              //           builder: (context) {
                              //             return const Center(
                              //               child: CircularProgressIndicator(),
                              //             );
                              //           });
                              //       var status =
                              //           await _cUser.checkStatus(context);
                              //       print(status);
                              //       if (status != null) {
                              //         if (status == 0) {
                              //           var data = {
                              //             'nom': widget.data['nom'], //Map
                              //             'prenom': widget.data['prenom'], //Map
                              //             'classe': widget.data['classe'],
                              //             'date_naissance':
                              //                 widget.data['date_naissance'],
                              //             'matricule': widget.data['matricule'],
                              //             'service': 'EXTRA SCOLAIRES',
                              //             'status': status,
                              //             'schoolid': widget.schoolid,
                              //           };
                              //           Get.back();

                              //           _cUser.showModal2(context, data);
                              //           // maintenance();
                              //         } else {
                              //           var data = {
                              //             'nom': widget.data['nom'], //Map
                              //             'prenom': widget.data['prenom'], //Map
                              //             'classe': widget.data['classe'],
                              //             'date_naissance':
                              //                 widget.data['date_naissance'],
                              //             'matricule': widget.data['matricule'],
                              //             'service': 'EXTRA SCOLAIRES',
                              //             'status': status,
                              //             'schoolid': widget.schoolid,
                              //           };
                              //           Get.back();

                              //           Get.to(() => GetScolarite(data: data),
                              //               fullscreenDialog: true);
                              //           // maintenance();
                              //         }
                              //       }
                              //     },
                              //     child: Card(
                              //       color: Theme.of(context)
                              //           .colorScheme
                              //           .primaryContainer,
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius:
                              //               BorderRadius.circular(15.0)),
                              //       elevation: 1,
                              //       child: Container(
                              //         height:
                              //             MediaQuery.of(context).size.height *
                              //                 0.2,
                              //         width: double.infinity,
                              //         decoration: const BoxDecoration(
                              //           borderRadius: BorderRadius.all(
                              //               Radius.circular(15)),
                              //           color: Colors.white,
                              //         ),
                              //         child: Padding(
                              //           padding: const EdgeInsets.all(15.0),
                              //           child: Center(
                              //             child: Column(
                              //               children: [
                              //                 SizedBox(
                              //                   height: 100,
                              //                   width: 100,
                              //                   child: Image.asset(
                              //                     'assets/images/sports.png',
                              //                     width: 50,
                              //                     height: 50,
                              //                   ),
                              //                 ),
                              //                 const SizedBox(height: 20),
                              //                 Text(
                              //                   'FRAIS EXTRA SCOLAIRES',
                              //                   style: TextStyle(
                              //                       color: Colors.black,
                              //                       fontSize:
                              //                           MediaQuery.of(context)
                              //                                   .size
                              //                                   .width *
                              //                               0.04,
                              //                       fontWeight:
                              //                           FontWeight.w500),
                              //                 )
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
