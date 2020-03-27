# Simplest example of how to play a file
import libvlc, os

proc play(file: string) = 
  # Create new VLC instance
  let vlc = libvlc.new(0, nil)
  # Create new media player
  let media_player = media_player_new(vlc)
  # Set the location for our media file
  let media = media_new_location(vlc, "file:///" & file)
  # Set that media to be the current one
  media_player_set_media(media_player, media)
  # Start playing it
  echo media_player_play(media_player)
  # I'm not sure why, but we need to sleep a bit before
  # being able to call media_player_is_playing
  sleep(500)
  # Sleep while music is playing
  while media_player_is_playing(media_player):
    sleep(500)

  # Release media object
  media_release(media)
  # Release media_player object
  media_player_release(media_player)
  # Release VLC instance
  libvlc.release(vlc)

when isMainModule:
  if paramCount() < 1:
    quit "Run: ./play file"
  try:
    play(expandFilename(paramStr(1)))
  except OSError:
    quit "There's no such file!"
