import osproc
import strutils

type Block* = object
  name*: string
  path*: string
  interval*: int
  signal*: int
  alignment*: char
  order*: int

var blocks* = newSeq[Block]()
var left*, center*, right*: int
var output* = newSeq[string]()

proc printBar(output: var seq[string], clearIndex: int = -1): void = 
  var index = 0
  for o in output:
    stdout.write(o)
    if index == clearIndex:
      output[index] = ""
    index += 1
  echo ""

proc runBlock*(b: Block): string =
  result = execProcess(b.path).replace("\n", " ")

proc updateBlock*(b: Block, oldOutput: var seq[string], leftIndex, centerIndex, rightIndex: int): seq[string] =

  var alignment = ""
  if b.order - 1 == leftIndex:
    alignment = "%{l}" 
  elif b.order - 1 == centerIndex:
    alignment = "%{c}" 
  elif b.order - 1 == rightIndex:
    alignment = "%{r}" 

  
  oldOutput[b.order - 1] = alignment & runBlock(b)
  printBar(output)
  result = oldOutput

proc updateBar*(b: Block): void =
  var alignment = ""
  if b.order - 1 == left:
    alignment = "%{l}" 
  elif b.order - 1 == center:
    alignment = "%{c}" 
  elif b.order - 1 == right:
    alignment = "%{r}" 
  output[b.order - 1] = alignment & runBlock(b)
  printBar(output)
