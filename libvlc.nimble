# Package

version       = "0.1.0"
author        = "Yardanico"
description   = "libvlc bindings for Nim"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.0.0", "nimterop"

when gorgeEx("nimble path nimterop").exitCode == 0:
  import nimterop/docs
  task docs, "Generate docs": buildDocs(@["src/libvlc.nim"], "build/htmldocs")
else:
  task docs, "Do nothing": discard