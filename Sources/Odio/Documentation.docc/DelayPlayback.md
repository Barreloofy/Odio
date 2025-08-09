# Delay Playback

## Overview

``Odio/AudioPlayer`` provides an argument label called `after` in its initializers,
it introduces a delay before playback occurs.
The default value is set to `0` and the time-interval is in seconds.

Specify a value in seconds to delay playback:
```swift
struct ContentView: View {
  @AudioPlayer(.tap, after: 1.0) private var audioPlayer

  var body: some View {
    Button("Tap Me") { audioPlayer() }
  } 
}
```
