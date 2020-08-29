import tables

from block_type import Block, blocks, updateBlock, updateBar

var signalToBlock* = initTable[int, int]()

proc c_signal(sig: cint, handler: proc (a: cint) {.noconv.}) {.importc: "signal", header: "<signal.h>".}

proc signal_handler(sig:cint) {.noconv.} =
  updateBar(blocks[signalToBlock[sig]])


proc signalFunction*(blocks: seq[Block]): void  =
  for b in blocks:
    let signal = b.signal.cint
    c_signal(signal, signal_handler)
