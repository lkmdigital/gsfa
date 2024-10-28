import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/c_user.dart';
import '../views/accueil.dart';
import '../views/drawer/ProfilePage.dart';
import '../views/history/historique_paiement.dart';
import '../views/support.dart';

class Root extends StatefulWidget {
  final String schoolid;

  const Root({Key? key, required this.schoolid}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  final CUser _cUser = Get.put(CUser());
  int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CUser(),
      initState: (state) {
        _cUser.getUser();
      },
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: getBottomBar(),
          body: getBarPage(),
        );
      },
    );
  }

  Widget getBottomBar() {
    return BottomNavigationBar(
      currentIndex: activeTab,
      onTap: (index) {
        setState(() {
          activeTab = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: "Accueil",
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.arrow_right_arrow_left),
          label: "Transactions",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.headset),
          label: "Support",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Profil",
        ),
      ],
      selectedItemColor: Theme.of(context).buttonTheme.colorScheme!.primary,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    );
  }

  Widget getBarPage() {
    return IndexedStack(
      index: activeTab,
      children: [
        Accueil(schoolid: widget.schoolid),
        Historique(),
        Support(schoolid: widget.schoolid),
        ProfilPage(),
      ],
    );
  }
}
