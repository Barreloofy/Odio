# Delay Playback

## Overview

Both ``Odio/AudioPlayer`` and `audioFeedback()` provide an argument label called `after` in its initializers,
specify a value in seconds for `after` to delay playback.

`@AudioPlayer`:
```swift
struct ContentView: View {
  @AudioPlayer(.tap, after: 1.0) private var audioPlayer

  var body: some View {
    Button("Tap Me") { audioPlayer() }
  } 
}
```

`audioFeedback()`:
```swift
var body: some View {
  Text("Tap Me")
    .audioFeedback(.tap, after: 1.0)
}
```
