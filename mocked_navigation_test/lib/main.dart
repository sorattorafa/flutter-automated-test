import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Routes {
  static namedRoutes(context) => <String, WidgetBuilder>{
        '/': (context) => const FirstPage(),
        '/second': (context) => const SecondPage(),
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Routes.namedRoutes(context),
      initialRoute: '/',
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed('/second'),
              child: const Text('PUSH'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/second'),
              child: const Text('REPLACE'),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('POP'),
        ),
      ),
    );
  }
}
