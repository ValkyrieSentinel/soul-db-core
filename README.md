# SoulDB Core

A minimalist, high-performance binary storage engine based on a page-oriented architecture.

## Overview
SoulDB Core is an architectural exploration of how databases manage data at the storage level. It implements a custom binary format using fixed-size pages, demonstrating low-level file system interaction and memory safety.

## Key Features
* **Custom Binary Format:** Uses a specific `SOULCODE` signature for file identification and integrity validation.
* **Page-Oriented Storage:** Manages data in 4KB blocks (pages), a fundamental concept in modern database engines like SQLite.
* **Low-Level Operations:** Implements direct binary serialization using Zig's `extern struct` and memory mapping capabilities.
* **Zero-Dependency:** Written in pure Zig, ensuring maximum control over the system's resources.

## Technical Stack
* **Language:** [Zig](https://ziglang.org/)
* **Concepts:** Binary Serialization, Paging, File I/O, Data Integrity.

## Why this project?
This project serves as a foundational engine for building scalable data storage solutions. By handling memory alignment and binary structures manually, it ensures minimal overhead and high efficiency for storage operations.

## Status
Active development of the core storage engine.