---
layout: post
title: "Atlas"
hidden: true
status: In Build (March 2021)
date: 2021-03-06
description: 'Software Design'
caption: "Initial memory architecture diagram."
image: /assets/images/atlas/memmap.png
author: Byron Theobald
tags: 
  - GPS
  - STM32
  - PCB
  - Mapping
  - Cycling
---

### Current Software Design

The software behind Atlas is probably the biggest challenge for the project and the part that will require me to learn a lot about working on complex embedded devices with a comparatively large amount of memory.

It is quite likely that the device will be memory constrained in the first instance. Memory bandwidth is also likely to be a concern, particularly from the bootloader SPI flash. Data would be copied into external RAM when the device is switched on, the entire contents of the flash could be copied into external RAM in less than a second, making this rate less of a concern.

This does mean that when power is lost, any data loaded into this RAM will also be lost and this data will need to be copied every time on boot. Any config data will be written to the flash when modified, previous location data should also be written allowing the map to immediately resume to the last location.

Theres a lot of separate tasks that will need to happen for this device to function properly, so it is likely that it will be based on an RTOS to provide a task scheduler and provide a greater level of hardware abstraction. I'm currently investigating Zephyr Project, particularly due to the build system that it provides.

Zephyr would also make integrating secure firmware upgrades possible using MCUboot. While not particularly important for a prototype, it would be interesting to experiment with on the route to product development.

#### Links

- [Introduction]({% post_url atlas/21-03-06-atlas %})
- [Hardware Design]({% post_url atlas/21-03-06-atlas-hardware %})
- [Mapping]({% post_url atlas/21-03-06-atlas-mapping %})
- Software Design
- [Repository](https://github.com/btheobald/atlas/tree/atlas_dev)
