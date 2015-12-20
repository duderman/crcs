lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# My implementation
require 'crcs'
# Slice-by-8 with native extension
require 'crc32'
# Standard zlib implementation
require 'zlib'
# Ruby implementation
# require 'digest/crc32'

# Generate some random data
require 'securerandom'
MEGABYTE = 2**20
data = SecureRandom.random_bytes(5 * MEGABYTE)

# Benchmark itself
require 'benchmark'
iterations = 1_000
Benchmark.bm do |bm|
  bm.report('crcs') { iterations.times { Digest::CRC32.hexdigest(data) } }
  bm.report('tdobrovolskij/crc32') { iterations.times { Crc32.calculate(data, data.length, 0) } }
  bm.report('zlib') { iterations.times { Zlib.crc32(data) } }
  # bm.report('postmodern/digest-crc') { iterations.times { Digest::CRC32.hexdigest(data) } }
end
