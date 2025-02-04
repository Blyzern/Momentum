import 'package:flutter/material.dart';
import "package:momentum/Pages/todo_page.dart";

void main() {
  runApp(const Momentum());
}

// To move in it's own file
BoxDecoration gradientBox(Color first, Color second) {
  return BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[first, second],
  ));
}
// ###########################

class Momentum extends StatelessWidget {
  const Momentum({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Momentum',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          surface: Color.fromARGB(255, 34, 40, 49),
          onPrimary: Colors.white,
          inversePrimary: Color.fromARGB(255, 39, 55, 77),
          primaryContainer: Color.fromARGB(255, 57, 62, 70),
          error: Colors.red,
        ),
        useMaterial3: true,
      ),
      home: DefaultPage(),
    );
  }
}

class DefaultPage extends StatefulWidget {
  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Placeholder();
      case 1:
        page = Placeholder();
      case 2:
        page = TodoPage();
      case 3:
        page = Placeholder();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 750,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary)),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.book),
                    label: Text('Phone Numbers',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary)),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.note),
                    label: Text("Todo",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary)),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.music_video),
                    label: Text('Audios',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary)),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                decoration: gradientBox(Theme.of(context).colorScheme.surface,
                    Theme.of(context).colorScheme.primaryContainer),
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}
