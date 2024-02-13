// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:music_app/components/neu_style.dart';
import 'package:music_app/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});
  @override
  Widget build(BuildContext context) {
    // Formatting time to secs
    String formatTime(Duration duration) {
      String inSeconds = duration.inSeconds
          .remainder(60)
          .toString()
          .padLeft(2, '0'); // Pad left gives extra 0 at end
      String formattedTime = "${duration.inMinutes}:$inSeconds";

      return formattedTime;
    }

    // So that it consumes playlist provider
    return Consumer<PlayListProvider>(builder: (context, value, child) {
      // Get the playist
      final playlist = value.playlist;

      // Get current song index
      final currentIndex = playlist[value.currentSongIndex ?? 0];

      // Return Scaffold UI
      return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          // appBar: AppBar(
          //   title: const Text("SONG"),
          // ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Custom Appbar
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios)),

                    // Title
                    Text(
                      "P L A Y L I S T",
                      style: TextStyle(fontSize: 25),
                    ),

                    // Menu button
                    IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                  ],
                ),

                // Album artwork
                NeuBox(
                    child: Column(
                  children: [
                    // Artwork
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(currentIndex.imagePath)),
                    // Song andf artist name
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentIndex.name,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                currentIndex.artist,
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          // Like icon
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        ],
                      ),
                    )
                  ],
                )),

                SizedBox(
                  height: 10,
                ),

                // Song duration progress
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(formatTime(value.currentDuration)),
                          Icon(Icons.shuffle),
                          Icon(Icons.repeat),
                          Text(formatTime(value.totalDuration)),
                        ],
                      ),
                    ),
                    // If we want to remove the circle from player
                    // SliderTheme(
                    //   data: SliderTheme.of(context).copyWith(
                    //       thumbShape: const RoundSliderThumbShape(
                    //           enabledThumbRadius: 0)),
                    //   child:
                    Slider(
                      min: 0,
                      max: value.totalDuration.inSeconds.toDouble(),
                      value: value.currentDuration.inSeconds.toDouble(),
                      activeColor: Colors.grey,
                      onChanged: (double double) {
                        // When user changes the slider
                      },
                      onChangeEnd: (double double) {
                        // When sliding is finished move to the given position
                        value.seek(Duration(seconds: double.toInt()));
                      },
                    ),
                  ],
                ),

                // Song controls
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Replay button
                      IconButton(
                        icon: Icon(
                          Icons.skip_previous_rounded,
                          size: 40,
                        ),
                        onPressed: () {
                          value.playPrevious();
                        },
                      ),

                      // Pause/Play button
                      IconButton(
                        icon: Icon(
                          value.isPlaying
                              ? Icons.pause_sharp
                              : Icons.play_arrow,
                          size: 40,
                        ),
                        onPressed: () {
                          value.pauseOrResume();
                        },
                      ),

                      // Next button
                      IconButton(
                        icon: Icon(
                          Icons.skip_next_rounded,
                          size: 40,
                        ),
                        onPressed: () {
                          value.playNext();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
    });
  }
}

// Body constains the big image of song within a container
// body: const Center(
//     child: NeuBox(
//   child: Icon(
//     Icons.search,
//     size: 40,
//   ),
// )),
