import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              'Carregando...',
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.titleLarge!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
