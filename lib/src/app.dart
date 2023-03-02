import 'package:flutter/material.dart';
import 'package:zona_hub/src/components/drawer.dart';
import 'package:zona_hub/src/views/Notifications/notifications.dart';
import 'package:zona_hub/src/views/home/home.dart';
import 'package:zona_hub/src/views/map/map.dart';
import 'package:zona_hub/src/views/profile/profile.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // Initial theme mode is the system theme mode
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ZonaHub',
          //Customize light theme
          theme: ThemeData(primarySwatch: Colors.red,),
          //Customize darak theme
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          
          home: Root(),
        );
      } 
    );
  }
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {

  int currentPage = 0;
  //Here goes the views Pages Home(), Map(), Profile(), etc.
  List<Widget> pages = const [HomePage(), MapPage(), NotificationsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Sidebar
      //Ingonar la recomendación de hacer constante el componente ya que contiene elementos que van a cambiar
      drawer: Drawer(
        child: DrawerComponent() 
      ),
      appBar: AppBar(
        title: const Text("Zona Hub"),
        actions: [
          IconButton(
            icon: const Icon( Icons.search ), 
            onPressed: () {
              //Search logic 
            },)
        ],
      ),
      body: pages[currentPage],
    
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.map), label: "Map"),
          NavigationDestination(icon: Icon(Icons.notifications), label: "Notifications"),
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


// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
  
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // Initial theme mode is the system theme mode
//   static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);
  
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<ThemeMode>(
//       valueListenable: themeNotifier,
//       builder: (context, currentMode, _) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'ZonaHub',
//           theme: ThemeData(primarySwatch: Colors.amber),
//           darkTheme: ThemeData.dark(),
//           themeMode: currentMode,
//           home: const Scaffold(),
//         );
//       } 
//     );

//   }
// }