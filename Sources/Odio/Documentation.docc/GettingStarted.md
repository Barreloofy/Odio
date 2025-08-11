# Getting Started with Odio

## Overview

Odio offers two different approaches for interacting with its API.
An imperative approach through the ``Odio/AudioPlayer`` property wrapper and
a declarative approach through the different `audioFeedback` view methods.
This article will give an overview of both approaches, starting with `AudioPlayer`.

### Create an AudioPlayer

Initialize an instance of ``Odio/AudioPlayer`` in of the following three ways:

Initialize an instance with a `String`.
```swift
@AudioPlayer("Tap.mp3") private var audioPlayer
```

Initialize an instance with a ``Odio/FileKey``.
```swift
@AudioPlayer(.tap) private var audioPlayer
```

Initialize an empty instance.
```swift
@AudioPlayer private var audioPlayer 
```

### Use AudioPlayer

The view is initialized with an empty `@AudioPlayer`,
once the view appears and its `onAppear()` method is called
the appropriate `OdioPlayer` is initialized and assigned to `audioPlayer`.
Then, playback occurs by calling the instance directly `audioPlayer()`.
```swift
struct ContentView: View {
  @AudioPlayer private var audioPlayer

  let result: String

  var body: some View {
    Text(result)
      .onAppear {
        if result == "Player X Won" {
          audioPlayer = .init("XWonAudio.mp3")
        } else {
          audioPlayer = .init("OWonAudio.mp3")
        }
      
        audioPlayer()
      }
  }
}
```

### Use audioFeedback

The `audioFeedback` API consists of different view methods applicable in different scenarios:

* ``SwiftUICore/View/audioFeedback(_:after:)-14mil`` Plays audio when the attached view is tapped.

* ``SwiftUICore/View/audioFeedback(_:after:shouldPlay:)-77u92`` Plays audio when shouldPlay is evaluated as true.

  * ``SwiftUICore/View/audioFeedback(_:after:trigger:)-60fd3`` Plays audio when trigger changes.

All of these methods have an overloaded version with ``Odio/FileKey`` instead of `String`,
See: <doc:UsingFileKey> to learn more.

``SwiftUICore/View/audioFeedback(_:after:)-14mil`` Plays `IncrementSound.mp3` every time the button is tapped.
```swift
var body: some View {
  Button("+ Increment") { ... }
    .audioFeedback("IncrementSound.mp3")
}
```

``SwiftUICore/View/audioFeedback(_:after:shouldPlay:)-77u92`` Every time `count` is even plays EvenSound.mp3
otherwise plays `OddSound.mp3`.
```swift
var body: some View {
  Text("\(count)")
    .audioFeedback("EvenSound.mp3") { count % 2 == 0 }
    .audioFeedback("OddSound.mp3") { count % 2 == 1 }
}
```

``SwiftUICore/View/audioFeedback(_:after:trigger:)-60fd3`` Plays "InsertSound.mp3" when a new `Int` is added 
to the Set `uniqueInts`.
```swift
var body: some View {
  Button("Generate Random Int") {
    uniqueInts.insert(Int.random(in: 0...50))
  }
  .audioFeedback("InsertSound.mp3", trigger: uniqueInts)
}
```
