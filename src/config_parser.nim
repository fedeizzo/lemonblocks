import yaml/serialization, streams
import os

from block_type import Block

proc readConfig*(configPath: string = ""): seq[Block] =
  var directoryList: seq[Block]
  var config = os.getEnv("XDG_CONFIG_HOME")
  if configPath != "":
    config = config & "/lemonblocks/" & configPath
  else:
    config = config & "/lemonblocks/config.yaml"
  var s = newFileStream(config)
  load(s, directoryList)
  s.close()
  result = directoryList
