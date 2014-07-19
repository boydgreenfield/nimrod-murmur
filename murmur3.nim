# Import Murmurhash3 code and compile at same time as Nimrod code
{.compile: "murmur3_c.c".}

type
  MurmurHashes* = array[0..1, int64]

proc raw_murmur_hash(key: cstring, len: int, seed: uint32, out_hashes: var MurmurHashes): void {.
  importc: "MurmurHash3_x64_128".}

proc murmur_hash*(key: string, seed: uint32 = 0'u32): MurmurHashes =
  ## Only implemented for strings at the moment. Returns an array of
  ## two 64-bit integers
  var result: MurmurHashes = [0'i64, 0'i64]
  raw_murmur_hash(key = key, len = key.len, seed = seed, out_hashes = result)
  return result

when isMainModule:
  let hash_outputs_a = murmur_hash("hello", 0)
  let hash_outputs_b = murmur_hash("hello", 10)

  doAssert int(hash_outputs_a[0]) == -3758069500696749310  # Correct murmur outputs (cast to int64)
  doAssert int(hash_outputs_a[1]) == 6565844092913065241

  doAssert hash_outputs_a[0] != hash_outputs_a[1]
  doAssert hash_outputs_a[0] != hash_outputs_b[0]
  doAssert hash_outputs_a[1] != hash_outputs_b[1]
  doAssert hash_outputs_b[0] != hash_outputs_b[1]

  echo "Successfully passed all tests."

