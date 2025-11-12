# Customize playback behavior

## Overview

Besides simple audio playback, `Odio` provides further customization of the following properties:

* `delay`: Customizing this property changes when playback should occur, e.g, setting this property to a value of `10` introduces a delay of 10 seconds before playback occurs.

* `repeatMode`: Customizing this property changes how many times playback should be repeated, there are three possible values, `never`, `count`, `loop` to set this property to.
  * `never`: Never repeats playback. 
  
  * `count(UInt)`: Repeats playback `count` number of times, e.g, `count(1)` will play audio a total of two times, once the original playback and one repeat.

  * `loop`: Repeats playback indefinitely.

- Note: Not all properties can be customized from every API.

### Adding delay to playback
Setting a playback delay is available for both `@AudioPlayer` and `audioFeedback` API's.
Delay is always specified in seconds, but can be fractions of a second as well, e.g, `1.0`, `0.5` are both valid values.

`audioPlayer` will start playback **after** `1` second.
```swift
@AudioPlayer("SomeSound.mp3", after: 1) private var audioPlayer

var body: Some View {
  Button("Play Sound") {
    audioPlayer()
  }
}
```

Every time this view appears start playback **after** `0.5` seconds.
```swift
var body: Some View {
  VStack {
    ...
  }
  .audioFeedback("AppearSound.mp3", after: 0.5) { true }
}
```

### Repeat playback
