
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _PickerDemo(),
    );
  }
}

class _PickerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // Navigator.push<void>(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const FullscreenGallery()),
                // );
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: const Text('Full screen mode'),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                // Navigator.push<void>(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const CollapsableGallery()),
                // );
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: const Text('Collapsable mode'),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}