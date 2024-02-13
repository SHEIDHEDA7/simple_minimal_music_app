import 'package:flutter/material.dart';
import 'package:music_app/components/drawer.dart';
import 'package:music_app/models/playlist_provider.dart';
import 'package:music_app/models/songs.dart';
import 'package:music_app/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Get playlist provider
  late final dynamic playListProvider;
  @override
  void initState() {
    super.initState();
    // Get playlist provider
    playListProvider = Provider.of<PlayListProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    // Giving the index of the pressed song
    playListProvider.currentSongIndex = songIndex;

    // Going to song page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SongPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("P L A Y L I S T"),
        backgroundColor: Colors.black45,
        shadowColor: Colors.black38,
        // elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlayListProvider>(
        builder: (context, value, child) {
          // Get playlist
          final List<Song> playlist = value.playlist;

          // Returns list of playlist UI
          return ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                // Get song
                final Song song = playlist[index];

                // Represent in list
                return ListTile(
                  title: Text(song.name),
                  subtitle: Text(song.artist),
                  leading:
                      SizedBox(width: 55, child: Image.asset(song.imagePath)),
                  onTap: () => goToSong(index),
                );
              });
        },
      ),
    );
  }
}
