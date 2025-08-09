# Safely and swiftly initialize audio players

## Overview

Using string literals to initialize audio players may work well initially,
but as the project grow, this becomes more cumbersome and error-prone.
there are different approaches one can take to resolve these issues, 
and one of these approaches is ``Odio/FileKey``,
this article will provide explanations on how to use ``Odio/FileKey``.

### What is FileKey?
`FileKey` is a struct-based type with the purpose of providing 
a safe and swift way to initialize audio players.
Extend ``Odio/FileKey`` with a static property for swift use later on.

### How to use FileKey?
First, extend `FileKey` with a static property:
```swift
extension FileKey {
  static let score = FileKey(value: "Score.mp3")
}
```

#### Use with @AudioPlayer
Instead of using the (_ name: String) version:
```swift
@AudioPlayer("Score.mp3") private var audioPlayer
```

Use the (_ key: FileKey) version:
```swift
@AudioPlayer(.score) private var audioPlayer
```

#### Use with audioFeedback
Instead of using the (_ name: String) version:
```swift
var body: some View {
  Text("Score: \(score)")
    .audioFeedback("Score.mp3") { score >= 10 }
}
```

Use the (_ key: FileKey) version:
```swift
var body: some View {
  Text("Score: \(score)")
    .audioFeedback(.score) { score >= 10 }
}
```
