murmur3
=======

Murmurhash3 wrapper in Nimrod. Currently simply provides a wrapper for MurmurHash3_x64_128 for string inputs. MurmurHash was written by Austin Appleby and released into the public domain.

This module implements a `MurmurHashes` type, which is simply a 2 item array of signed 64-bit integers, and one hashing method (strings only at the moment):
```nimrod
proc murmur_hash*(key: string, seed: uint32 = 0'u32): MurmurHashes =
```
