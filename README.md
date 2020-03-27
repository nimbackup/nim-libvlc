This project is a [Nim](https://nim-lang.org/) wrapper for the [libvlc](https://wiki.videolan.org/LibVLC/) library.

It is distributed as a [Nimble](https://github.com/nim-lang/nimble) package and depends on [nimterop](https://github.com/genotrance/nimterop) to generate the wrappers. The libvlc source code is downloaded using Git so having ```git``` in the path is required.

__Installation__

This package can be installed via [Nimble](https://github.com/nim-lang/nimble):

```
> nimble install libvlc
```

This will download, wrap and install the libvlc wrapper in the standard Nimble package location, typically ~/.nimble. Once installed, it can be imported into any Nim program.


__Credits__

This project wraps the libvlc source code and all licensing terms of [VLC](https://www.videolan.org/legal.html) apply to the usage of this package.

__Feedback__

This project is a work in progress and any feedback or suggestions are welcome. It is hosted on [GitHub](https://github.com/Yardanico/nim-libvlc) with an MIT license so issues, forks and PRs are most appreciated.