# Simplest example of how to play a file
# Don't forget that you can use both snake_case and camelCase
import std/os
import libvlc

proc play(file: string) = 
  # Create new VLC instance
  let vlc = newVlc(0, nil)
  defer: vlc.release()
  # Set the location for our media file
  let media = mediaNewLocation(vlc, cstring("file:///" & file))
  defer: mediaRelease(media)
  # Create new media player with needed media
  let mp = mediaPlayerNewFromMedia(media)
  defer: mediaPlayerRelease(mp)
  # Start playing it
  echo mediaPlayerPlay(mp)
  # I'm not sure why, but we need to sleep a bit before
  # being able to call media_player_is_playing
  sleep(500)
  # Sleep while music is playing
  while bool(mediaPlayerIsPlaying(mp)):
    sleep(500)
    echo "Current position - " & $mediaPlayerGetPosition(mp)

when isMainModule:
  if paramCount() < 1:
    quit "Run: ./play file"
  try:
    play(expandFilename(paramStr(1)))
  except OSError:
    quit "There's no such file!"