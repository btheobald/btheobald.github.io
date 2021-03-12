---
layout: post
title: "Atlas"
hidden: true
status: In Build (March 2021)
date: 2021-03-06
description: 'Mapping'
caption: "Prototype lightweight MVT map renderer"
image: /assets/images/atlas/mapex.png
author: Byron Theobald
tags: 
  - GPS
  - STM32
  - PCB
  - Mapping
  - Cycling
---

### Map Formats

I also, where possible want to make use of standard mapping formats, OpenStreetMap data is under a Creative Commons Attribution-ShareAlike 2.0 License, and so is free to use for this sort of project and could still be used comercially. 

Several standards exist to make processing these maps more effcient, such as Mapbox Vector Tiles, which splits up a map into smaller recursive tiles held in a SQL database, or Mapsforge which provides map data in a indexed binary file. Using these formats would mean that additional maps could easily be stored on an SD card and updated reguarly. 

Vector formats are small, requiring around a gigabyte to map the entire of the United Kingdom down to street level The main detraction of vector tiles is the memory requirements of decoding and the processing required to perform the rendering. In some cases, these formats also support compression of the individual tiles, which could decrease the transfer time of a large tile over a relatively slow SD interface. However this then requires more processing.

##### Links

- [Introduction]({% post_url atlas/21-03-06-atlas %})
- [Hardware Design]({% post_url atlas/21-03-06-atlas-hardware %})
- Mapping
- [Software Design]({% post_url atlas/21-03-06-atlas-software %})
- [Repository](https://github.com/btheobald/atlas/tree/atlas_dev)
