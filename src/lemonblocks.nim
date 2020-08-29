import tables
import os

from block_type import Block, blocks, output, left, center, right, runBlock
from config_parser import readConfig
from interval_handler import intervalFunction
from signal_handler import signalFunction, signalToBlock

proc prepareOutput(blocks: seq[Block]): (int, int, int) = 
  var
    firstLeft = high(int)
    firstCenter = high(int)
    firstRight = high(int)

  for b in blocks:
    if b.alignment == 'l' and b.order < firstLeft:
      firstLeft = b.order - 1
    elif b.alignment == 'c' and b.order < firstCenter:
      firstCenter = b.order - 1
    elif b.alignment == 'r' and b.order < firstRight:
      firstRight = b.order - 1

  result = (firstLeft, firstCenter, firstRight)

proc initOutput(blocks: seq[Block], left, center, right: int): seq[string] =
  result = newSeq[string]()
  for b in blocks:
    var alignment = ""
    if b.order - 1 == left:
      alignment = "%{l}"
    elif b.order - 1 == center:
      alignment = "%{c}"
    elif b.order - 1 == right:
      alignment = "%{r}"
    result.add(alignment & runBlock(b))

when isMainModule:
  var config: seq[Block]
  if paramCount() == 1:
    config = readConfig(paramStr(1))
  else:
    config = readConfig()

  var index = 0
  for c in config:
    if c.signal != -1:
      signalToBlock.add(c.signal, index)
    index += 1

  
  blocks.add(config)

  (left, center, right) = prepareOutput(blocks)

  output = initOutput(blocks, left, center, right)

  signalFunction(blocks)
  intervalFunction(blocks, blocks.len, output, left, center, right)
