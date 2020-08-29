import os
import tables
import algorithm
import times

from block_type import Block, runBlock, updateBlock

proc sortInterval(blocks: seq[Block]): (Table[int, seq[Block]], seq[int]) =
  var table = initTable[int, seq[Block]]()
  var intervals = newSeq[int]()

  for b in blocks:
    var tmpSeq: seq[Block]
    if table.hasKey(b.interval):
      tmpSeq = table[b.interval]
    else:
      tmpSeq = newSeq[Block]()

    tmpSeq.add(b)
    table.add(b.interval, tmpSeq)
    intervals.add(b.interval)

  intervals.sort
  result = (table, intervals)


proc intervalFunction*(blocks: seq[Block], blocksNumber: int, output: var seq[string], firstLeft: int, firstCenter:int, firstRight:int)  =
  var (intervalToBlocks, intervals) = sortInterval(blocks)

  while true:
    for i in {1..max(intervals)}:
      for b in blocks:
        if b.interval != -1 and b.signal == -1 and i mod b.interval == 0:
          output = updateBlock(b, output, firstLeft, firstCenter, firstRight)
      sleep(1*1000)

