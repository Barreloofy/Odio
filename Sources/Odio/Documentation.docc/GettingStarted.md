# Getting Started with Odio

## Overview

Odio offers two different approaches for interacting with its API.
An imperative approach through the ``Odio/AudioPlayer`` property wrapper and
a declarative approach through the different `audioFeedback` view methods.
This article will give an overview of both approaches, starting with `AudioPlayer`.

## Create an AudioPlayer

Initialize an instance of ``Odio/AudioPlayer`` in of the following three ways.

Initialize an instance with a `String` literal:
```swift
@AudioPlayer("TapSound.mp3") private var audioPlayer
```

Initialize an instance with a key path:
```swift
@AudioPlayer(\.tap) private var audioPlayer
```

Initialize an empty instance:
```swift
@AudioPlayer private var audioPlayer 
```

## Use AudioPlayer
Control audio playback by interacting with an instance of `@AudioPlayer`.

Here, the view is initialized with an empty `@AudioPlayer`,
once the view appears and its `onAppear()` method is called,
the appropriate `OdioPlayer` is initialized and assigned to `audioPlayer`.
Then, playback occurs by calling the instance directly: `audioPlayer()`.
```swift
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
```

## Use audioFeedback

The `audioFeedback` API consists of different view methods applicable in different scenarios:

* ``SwiftUICore/View/audioFeedback(_:after:)-(String,_)`` Plays audio when the attached view is tapped.

* ``SwiftUICore/View/audioFeedback(_:after:shouldPlay:)-(String,_,_)`` Plays audio when shouldPlay is evaluated to true.

* ``SwiftUICore/View/audioFeedback(_:after:trigger:)-(String,_,_)`` Plays audio when trigger changes.

All of these methods have a `KeyPath` overload, to learn more, see: <doc:UsingFileKey>.

### audioFeedback examples.

``SwiftUICore/View/audioFeedback(_:after:)-(String,_)`` If the button is tapped plays the `OpenSound.mp3`:
```swift
var body: Some View {
  ...
  Button("Open") { ... }
    .audioFeedback("OpenSound.mp3")
  ...
}
```

``SwiftUICore/View/audioFeedback(_:after:shouldPlay:)-(String,_,_)`` Every time `count` changes evaluates the closure, if the closure retuns true plays `EvenSound.mp3`:
```swift
...
var body: Some View {
  VStack {
    Button("+") { ... }

    Text("\(count)")

    Button("-") { ... }
  }
  .audioFeedback("EvenSound.mp3") { count % 2 == 0 }
}
```

``SwiftUICore/View/audioFeedback(_:after:trigger:)-(String,_,_)`` Every time `count` changes plays `ChangeSound.mp3`:
```swift
  ...
  var body: Some View {
    ...
    Text("Current Count: \(count)") 
      .audioFeedback("ChangeSound.mp3", trigger: count)
    ...
  }
```
