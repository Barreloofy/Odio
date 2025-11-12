# Safely and swiftly initialize audio players

## Overview

Using string literals to initialize audio players may work well initially,
but as the project grows, this becomes more cumbersome and error-prone.
There are different approaches one can take to resolve these issues, 
one of these approaches is ``Odio/FileKey``.

### What is FileKey?
At its essence, `FileKey`, offers an interface through which you reference files.

### How to use FileKey?
First, extend `FileKey` with new properties and attaching the @Entry macro to the variable declarations:
```swift
extension FileKey {
  @Entry var tap = "TapSound.mp3"
}
```

#### Using Filekey
All of `Odio`'s API's that offer a version which reference a file through a string, 
also offer a `FileKey` overload in the form of: `KeyPath<FileKey, String>`.

Instead of using the (_ fileName: String) version:
```swift
@AudioPlayer("TapSound.mp3") private var audioPlayer
```

Use the (_ keyPath: KeyPath<FileKey, String>)) version:
```swift
@AudioPlayer(\.tap) private var audioPlayer
```

Instead of using the (_ fileName: String) version:
```swift
var body: some View {
  Button("+") { ... }
    .audioFeedback("TapSound.mp3")
}
```

Use the (_ keyPath: KeyPath<FileKey, String>) version:
```swift
...
var body: some View {
  Button("+") { ... }
    .audioFeedback(\.tap)
}
```
