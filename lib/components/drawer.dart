import 'package:flutter/material.dart';
import 'package:music_app/pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Icon(
                  Icons.music_note,
                  size: 50,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),

            // Home tile
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 15),
              child: ListTile(
                title: const Text("H O M E"),
                textColor: Theme.of(context).colorScheme.inversePrimary,
                leading: const Icon(Icons.home),
                onTap: () => Navigator.pop(context),
              ),
            ),

            // Setting Tile
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: ListTile(
                title: const Text("S E T T I N G "),
                textColor: Theme.of(context).colorScheme.inversePrimary,
                leading: const Icon(Icons.settings),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ))
                },
              ),
            )
          ],
        ));
  }
}
