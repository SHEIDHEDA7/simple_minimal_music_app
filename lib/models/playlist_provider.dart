// ignore_for_file: prefer_final_fields, camel_case_types
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/songs.dart';

class PlayListProvider extends ChangeNotifier {
  // PLAYLIST
  List<Song> _playlist = [
    // Song 1
    Song(
        name: "Funny Valentine",
        artist: "MISAMO",
        audioPath: "/audio/Funny Valentine.mp3",
        imagePath: "assets/images/WPCL-13483.jpg"),

    // Song 2
    Song(
        name: "Do Not Touch",
        artist: "MISAMO",
        audioPath: "/audio/MISAMO Do not touch MV.mp3",
        imagePath: "assets/images/misamo-do-not-touch.jpg"),

    // Song 3
    Song(
        name: "Doughnut",
        artist: "Twice",
        audioPath: "/audio/TWICE 「Doughnut」 Music Video.mp3",
        imagePath: "assets/images/twice-doughnut-album-2_590x.jpg"),
  ];

  // Index of the current song
  int? _currentSongIndex;

  // Audio Player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Control durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor
  PlayListProvider() {
    listenToDuration();
  }

  // Not playing initially
  bool _isPlaying = false;

  // Play selected song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); // Stops currently playing song if so
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  // Pause
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // Resume
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // Pause or resume
  void pauseOrResume() async {
    if (_isPlaying == true) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // Seek to specific position in current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
    notifyListeners();
  }

  // Play next
  void playNext() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        // Not the last song of playlist
        currentSongIndex = _currentSongIndex! + 1;
        notifyListeners();
      } else {
        // Last song of playlist, play the first one
        currentSongIndex = 0;
        notifyListeners();
      }
    }
  }

  // Play previous
  void playPrevious() async {
    // If song duration is more than 2 secs, then restart the song
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    }
    // If within 2 secs, play prev song if in bw, else play last song of playlist
    else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  // Listen to duration
  void listenToDuration() {
    // Listen current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    // Listen total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    // Listen song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNext();
    });
  }

  // Dispose audio player

  // Getters
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // Setters
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }

    notifyListeners();
  }
}
