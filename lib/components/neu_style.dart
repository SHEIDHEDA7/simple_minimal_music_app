import 'package:flutter/material.dart';
import 'package:music_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';
// import 'package:music_app/themes/theme_provider.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;

  const NeuBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    bool DarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        // Make the container have shadows
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: DarkMode ? Colors.black : Colors.grey.shade500,
                  blurRadius: 15,
                  // For coordinate of shadow
                  offset: const Offset(4, 4)),
              BoxShadow(
                  color: DarkMode ? Colors.grey.shade800 : Colors.white,
                  blurRadius: 15,
                  // For coordinate of shadow
                  offset: const Offset(-4, -4))
            ]),
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}
