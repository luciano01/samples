import 'package:flutter/material.dart';

import 'samples/lazy_loading/lazy_loading_home.dart';

class AppPage extends StatelessWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Samples'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        children: [
          ElevatedButton(
            child: const Text('Lazy Loading'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const LazyLoadingHome(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
