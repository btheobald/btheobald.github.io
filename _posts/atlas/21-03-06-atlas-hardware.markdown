---
layout: post
title: "Atlas"
hidden: true
status: In Build (March 2021)
date: 2021-03-06
description: 'Hardware Design'
caption: "Revision A PCB for Atlas"
image: /assets/images/atlas/atlastbsa.png
author: Byron Theobald
tags: 
  - GPS
  - STM32
  - PCB
  - Mapping
  - Cycling
---

### Current Hardware Design

The hardware design has been through several iterations, each time the level of capability being targeted has increased somewhat. 

**Processor Selection** - Initial designs looked at the STM32L5 and STM32L4+ parts, which are Cortex M33 and Cortex M4 parts respectively, both of which clock at over 100MHz and have floating-point units.
This version makes use of a STM32H723, an SoC implementing a Cortex M7 running at up to 550MHz in boost. This part blurs the line bettween a microcontroller and a application processor and should provide a lot of flexibility to firmware development at a very reasonable cost in single quantities (~£10).

**STM32H723 Key Specs:**
- 550MHz Cortex M7
- 32kB D-Cache, 32kB I-Cache
- 1MB Flash
- 564kB SRAM
- Octo-SPI Interface with XiP
- SD interface up to UHS-1
- 24-Bit RGB LCD Controller
- CORDIC Trigonometric Accelerator

This microcontroller is no slouch, the best part is that it is avaliable in a 100-pin LQFP, meaning that it would be very feasible for me to use in reasonably low density design.

**Memory** - The ammount of RAM is a major concern for this project, as it requires a frame-buffer for rendering (With consideration given to double-buffering) and also memory to load in and process map data in a vector or raster format.

OctoSPI theoreticallys double the maximum bandwith to an external memory compared to QSPI. The controller is also compatible with the HyperBus protocol, which takes it one step further and implements Double-Data Rate (DDR). This enables up to 200MB/s on a 100MHz using just 11-pins. DRAM is avaliable in 24-Ball FBGA packages with 1mm pitch. While I would normally try to stay away from BGA, this seems quite tame and provides large external memories (32-128Mb), while also allowing me to attempt BGA soldering.

With other variants of the chip, 2 OctoSPI controllers are avaliable, or even one in multiplexed mode. The pin-out of the 100-pin LQFP does not allow this so in the event that extra non-volatile storage is needed, an aditional SPI 32Mb flash chip is connected in 1x mode. This should be capable of 133MHz, and while it won't support XiP, I've envisioned that at boot any application code could be copied via DMA into the large OctoSPI DRAM. It would take just 4 seconds to move the entire capacity of this flash chip into RAM.

**Display** - Another attraction of this SoC is the built in TFT controller, which allows for a up to 24-bit RGB LCD to be connected directly. for the 100-pin chip the full 24-bits is impractical at best, STM32Cube allows you to configure the peripheral as 16, 18 or 24 bits, however the datasheet makes no reference to these modes. This indicates that the number of bits is purely configured by the alternate function config for each pin, allowing for arbitrary colour depths.

I have access to an *old* 24-bit TFT-LCD stripped out of a first generation Sony Playstation Portable ([LQ043T1DG03](http://cdn.sparkfun.com/datasheets/LCD/Color/LQ043T1DG03.pdf)), and i've been looking for a project to use this in for a while. While not an ideal screen for outdoor use, it will suffice for use on a platform for proving software. It does require a 5V rail and a fairly high backlight voltage, which add some complexity to the power supply design."

---

### Power Supply

**Battery** - A large portion of the board is dedicated to power-supply, the design will ideally run of a single lithium-polymer cell. This is run through a standalone TI BQ25606, which is a 3A capable SMPS charger which provides Narrow-Voltage DC (NVDC), ensuring that the main system rail always runs bettween 3.5 and 4.5V, even while charging. This simplifys the later power stages somewhat, as we can use a simple Buck converter or LDO for the primary 3.3V rail instead of requiring a more expensive Buck-Boost. For battery State-of-Charge monitoring, I also included a MAX17048 fuel-gauge on an I2C interface.

**Primary** - The primary rail is where things get interesting, I made the design as low-power as physically possible in the off-state without software. To acheive this, I took the enable pin of the 3.3V regulator (TLV62569) and connect this to an output on the core. This might seem unwise, however the core has a backup power supply, provided by a low Iq 3.0V LDO (MCP1810). The reference manual states that the pull-ups will remain operational during the lowest power modes on certain 'Backup IO'.
The power button for the device is connected to the backup voltage, so that when pressed the voltage goes through a 'bootstrap' schottky diode and onto the enable pin of the regulator. Once the microcontroller has started, it can take over control of this pin and hold enable high itself. The schottky diode allows the button to be utilised in the software.

**Core** - While there is a version of the STM32H72x produced with a built in SMPS to improve effciency, The 100-pin LQFP variant cannot be configured to use OctoSPI. In order to use both I would need to step up to the 100-Ball TFBGA with a 0.8mm pitch, stock of which is currently non-existent. For sake of comparison, I included an external SMPS (ST1PS02) with an adjustable output of 1-1.35V. The voltage required is dependant on clock frequency. This external core voltage can be fed in via the VCAP pins when the internal LDO is bypassed.

**LCD** - There are two other primary regulators on the board, both of which are boost converters. One 5V boost converter (MCP1640) produces the analog voltage required for the LCD, the other is a constant current LED driver (LV52204), and is almost the same design that I implemented years ago for Atom/Aim. A PWM signal can be used to control the backlight brightness.

#### Links

- [Introduction]({% post_url atlas/21-03-06-atlas %})
- Hardware Design
- [Mapping]({% post_url atlas/21-03-06-atlas-mapping %})
- [Software Design]({% post_url atlas/21-03-06-atlas-software %})
- [Repository](https://github.com/btheobald/atlas/tree/atlas_dev)
