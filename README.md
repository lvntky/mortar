# Mortar

Welcome to Mortar Bootloader!
Mortar is custom, bloat-free bootloader and boot protocol designed for general purpose operating systems. Tailored specifically for x86-64 (AMD64) architecture.

## Table of Contents

1. [Introduction](#introduction)
2. [Bootloader Overview](#bootloader-overview)
3. [Boot Process](#boot-process)
4. [Memory Layout](#memory-layout)
5. [File System Support](#file-system-support)
6. [Boot Parameters](#boot-parameters)
7. [Custom Extensions](#custom-extensions)
8. [Contributing](#contributing)
9. [License](#license)

## Introduction

Mortar's origins started with Artillery OS. While programming Artillery OS, I worked with different bootloaders. Although most of them were very valuable, they were much more complex than what I needed and difficult to integrate into the project. Therefore, I decided to write a useful bootloader and protocol that can be used in Artillery OS and of course other operating systems seamlesly.

## Bootloader Overview

- **Name**: Mortar Bootloader
- **Architecture**: x86-64 (AMD64)
- **File System Support**: FAT32, ext4
- **Bootable Media**: USB, HDD
- **Programmed In** : [nasm](https://www.nasm.us/), C

## Boot Process

### First Stage Bootloader

- Loads from MBR or UEFI boot partition.
- Initializes CPU in 16-bit mode, sets up stack, and basic hardware.
- Determines boot device and loads second stage bootloader.

### Second Stage Bootloader

- Loads from predefined memory location.
- Sets up GDT, IDT, and switches to Long Mode (64-bit).
- Enables paging and prepares environment for kernel handoff.

### Kernel Handoff

- Passes control to kernel at specified entry point.
- Provides boot parameters including memory map and command line.

## Memory Layout

- **0x00007C00-0x00007DFF**: First Stage Bootloader
- **0x00100000-0x001FFFFF**: Second Stage Bootloader
- **0x00200000-0x00FFFFFF**: Kernel and Kernel Data

## File System Support

- Supports FAT32 and ext4 file systems for reading kernel and initrd images.
- Provides basic file system drivers for boot media access.

## Boot Parameters

- Structured format for passing boot parameters to kernel.
  ```c
  struct boot_params {
      uint64_t mem_lower;      // Lower memory (in MB)
      uint64_t mem_upper;      // Upper memory (in MB)
      char cmdline[256];       // Command line arguments
      uint32_t boot_device;    // Boot device identifier
      uint32_t disk_info;      // Disk information
  };

Custom Extensions

- Future plans for integrating ACPI support and secure boot mechanisms.
- Collaboration with Artillery OS kernel for seamless integration and updates.

## Contributing

Contributings are welcome, please open a issue first and let's discuss.

## License
Mortar is under [MIT](LICENSE) license
