# Customize playback behavior

## Overview

Besides simple audio playback, `Odio` provides further customization of the following properties:

* `delay`: Customizing this property changes when playback should occur, e.g, setting this property to a value of `10` introduces a delay of 10 seconds before playback occurs.

* `repeatMode`: Customizing this property changes how many times playback should be repeated, there are three possible values, `never`, `repeating`, `loop` to set this property to.
  * `never`: Never repeats playback. 
  
  * `repeating(UInt)`: Repeats playback count number of times, e.g, `repeating(1)` will playback audio a total of two times, once the original playback and one repeat.

  * `loop`: Repeats playback indefinitely.

- Important: Customizing any of these properties doesn't have any effect while playback is occurring, 
the new value will take effect with the next playback. E.g, setting `repeatMode` to `never` while playback is occuring 
with `repeatMode` set to `loop` won't stop playback, instead, simply start a new playback.

- Note: Not all properties can be customized from every API. 
Furthermore, the following examples only show initializer customization, 
for @AudioPlayer each property can also be directly customize by referring to it directly.

## Adding delay to playback
Specifying playback delay is available for both `@AudioPlayer` and `audioFeedback` API's.
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

Every time this view appears, start playback **after** `0.5` seconds.
```swift
var body: Some View {
  VStack {
    ...
  }
  .audioFeedback("AppearSound.mp3", after: 0.5) { true }
}
```

## Repeat playback
Specifying the repeat mode to use is only available for the `@AudioPlayer` API.
Set a specific mode by selecting one of the `RepeatMode` cases.

Here, pressing the button, plays the audioPlayer's audio **twice**.
```swift
@AudioPlayer("RepeatSound.mp3", repeatMode: .repeating(1)) private var audioPlayer

var body: Some View {
  Button("Play Sound Twice") {
    audioPlayer()
  }
}
```
