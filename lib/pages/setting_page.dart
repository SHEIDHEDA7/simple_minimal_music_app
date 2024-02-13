import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S E T T I N G S"),
        shadowColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 50),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(right: 40, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Text
              const Text(
                "Dark Mode",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              // Switch
              CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context, listen: false)
                    .isDarkMode,
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .changeTheme(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
