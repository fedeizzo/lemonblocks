# Lemonblocks
Lemonblocks is a modular lemonbar constructor. It aims to simplify and optimize the use of lemonbar.

## Installation
The installation can be done with three simple command:
```
git clone https://github.com/fedeizzo/lemonblocks.git
cd lemonblocks
nimble install
```
### Dependencies 
List of deps:

* nimble (make)
* nim (make)
* lemonbar (run)

## Configuration
The configuration is made via yaml standard. Here there is a [sample](./config.yaml).

Every "block" must have:

* name: name of the block
* path: path to the script or command
* interval: interval at which the path is executed (in second). -1 for no interval
* signal: signal used to call a refresh (ie. kill -3 lemonblocks). -1 for no signal
* alignment: alignment of the block (see lemonbar reference for more infos)
* order: order used to display element (from 1)

```
-
    name: Date
    path: /usr/bin/date
    interval: 30
    signal: -1
    alignment: l
    order: 1
```
