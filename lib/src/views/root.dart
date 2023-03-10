import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zona_hub/src/components/drawer.dart';
import 'package:zona_hub/src/services/Auth/sign_in_provider.dart';
import 'package:zona_hub/src/views/permissions/permission.dart';
import 'home/home.dart';
import 'map/map.dart';
import 'notifications/notifications.dart';
import 'package:provider/provider.dart';

class Root extends StatefulWidget {
  const Root({super.key});
  
  static SignInProvider user = SignInProvider();
  
  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int currentPage = 0;
  PermissionStatus? _status;
  //Here goes the views Pages Home(), Map(), Profile(), etc.
  List<Widget> pages = const [
    HomePage(),
    MapPageProvider(),
    NotificationsPage()
  ];

  void _requestPermission() async {
    _status = await Permission.locationWhenInUse.status;
    if (_status != PermissionStatus.granted) {
      _goRequestPermission();
    }
  }

  void _goRequestPermission() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => const RequestPermissionPage()));
  }

  //Data from Shared Preferences (logged user)

  Future getData()async{
    final sp = context.read<SignInProvider>();
    sp.getDataFromSP();
    Root.user = sp;
  }

  @override
  void initState() {
    debugPrint("Se construye Root");
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => _requestPermission());
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Sidebar
      //Ingonar la recomendación de hacer constante el componente ya que contiene elementos que van a cambiar
      drawer: Drawer(child: DrawerComponent()),
      appBar: AppBar(
        elevation: 0,
        title: const Text("Zona Hub"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              //Search logic
            },
          )
        ],
      ),
      body: pages[currentPage],

      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        height: 60,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.location_pin),
            label: 'Maps',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications),
            label: 'Notificaciones',
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
