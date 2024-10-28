import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../widgets/toast_alert.dart';
import 'paiement.dart';

class ModePaiement extends StatefulWidget {
  Map data;
  final montant;
  final String echeancier;

  ModePaiement(
      {Key? key,
      required this.data,
      required this.montant,
      required this.echeancier})
      : super(key: key);

  @override
  State<ModePaiement> createState() => _ModePaiementState();
}

class _ModePaiementState extends State<ModePaiement> {
  final TextEditingController _telephoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat myFormat = NumberFormat.decimalPattern('eu');
    Size size = MediaQuery.of(context).size;
    var v1 = widget.montant.toString();

    var v11 = v1.replaceAll(RegExp(r"\s+"), "");
    var v2 = int.parse(v11);
    var fraisWave = (v2 * 1 / 100).ceil();
    var fraisMTN = (v2 * 1 / 100).ceil();
    var fraisVISA = (v2 * 2.5 / 100).ceil();
    var fraisOrange = (v2 * 1 / 100).ceil();

    var fraisEliah = (v2 / 100).ceil();

    var wave = v2 + fraisEliah;
    var mtn = v2 + fraisEliah;
    var orange = v2 + fraisEliah;
    var visa = v2 + fraisVISA + fraisEliah;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choix de l'opérateur"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 8,
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    Navigator.of(context).pop();

                    var data = widget.data;

                    Get.to(() => PaiementPage(
                          data: data,
                          mode: 'WAVECI',
                          montant: v2,
                          frais: 0,
                          frais_eliah: 'FRAIS ELIAH.CI',
                          eliah: fraisEliah,
                          tel: _telephoneController.text.toString(),
                          echeancier: widget.echeancier.toString(),
                        ));

                    // paywave();
                  });
                },
                // -----------------------------------------------------------------------
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/wave.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right_sharp,
                      // color: Colors.grey,
                      size: 20,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Wave',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          // '${v2 + fraisWave} F CFA',
                          '1% - ${myFormat.format(wave)} FCFA',
                          // '2.5% - Frais marchand',

                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 8,
              child: InkWell(
                onTap: () {
                  // maintenance();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    Navigator.of(context).pop();

                    var data = widget.data;
                    // maintenance();
                    Get.to(() => PaiementPage(
                          data: data,
                          mode: 'OMCI',
                          frais: 0,
                          eliah: fraisEliah,
                          frais_eliah: 'FRAIS ORANGE.CI',
                          montant: v2,
                          tel: _telephoneController.text.toString(),
                          echeancier: widget.echeancier.toString(),
                        ));
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/orange.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: Colors.grey,
                      size: 20,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Orange Money',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          '1% - ${myFormat.format(orange)} FCFA',
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          SizedBox(
            height: Get.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 8,
              child: InkWell(
                onTap: () {
                  // maintenance();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    Navigator.of(context).pop();

                    var data = widget.data;
                    // maintenance();
                    Get.to(() => PaiementPage(
                          data: data,
                          mode: 'CARD',
                          frais: fraisVISA,
                          eliah: fraisEliah,
                          frais_eliah: 'FRAIS ELIAH.CI',
                          montant: v2,
                          tel: _telephoneController.text.toString(),
                          echeancier: widget.echeancier.toString(),
                        ));
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Container(
                        // height: size.height * 0.1,
                        // width: size.width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                          image: const DecorationImage(
                            image:
                                AssetImage('assets/images/visa_mastercard.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: Colors.grey,
                      size: 20,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'VISA / MASTERCARD',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        // const Text("Indisponible")
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.01,
                        // ),
                        Text(
                          '3.5% - ${myFormat.format(visa)} FCFA',
                          style: Theme.of(context).textTheme.titleSmall,
                          // '3.5% - Frais marchand',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
