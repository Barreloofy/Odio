# Control playback repeat behavior

## Overview

``Odio/AudioPlayer`` offers control over playback repeat behavior through its `repeatMode` property.
`repeatMode` is of type ``Odio/RepeatMode``, an enum, specify one of two available cases.
* loop: Indefinitely loops playback.
* count(UInt): Repeats playback the specified number of times, default case, with a value of 0. 

> Important: for `RepeatMode.count(UInt)` The default value is 0 meaning playback will **occur once** and no additional playback will occur. Thus, the value specified is additive, the orginal playback **plus** the specified value: AudioPlayer.repeatMode = 10 will playback audio **11 times**.

Before each playback call, the internal player is set to the value of `repeatMode`,
changing `repeatMode` while playback occurs has no effect. 
Call `stop()`, `end()` or a new playback call to make the change take affect.
```swift
struct ContentView: View {
  @AudioPlayer(.tap, repeatMode: .loop) private var audioPlayer
  @State private var count = 0

  var body: some View {
    Button("Count: \(count)") {
      count += 1
      audioPlayer.repeatMode = .count(UInt(count - 1))
      audioPlayer()
    }
  }
}
```
