# Crcs

This gem provides C extension for calculating CRC32 digests. It's based on
table-driven slice-by-8 CRC32 algorithm.

## Installation

Nothing special. Simply run

```
gem install crcs
```

or add folowing line to your Gemfile

```ruby
gem 'crcs'
```

## Using

This gem integrates to Ruby Digest module. This way you can easily use
all methods that this module provides. Just use `Digest::CRC32` class after
requiring gem into your code. For example:

```ruby
# Generate hexdigest for sample string
Digest::CRC32.hexdigest('Your data')
# or
crc32 = Digest::CRC32.new
crc32 << 'Data'
crc32 << 'More data'
crc32.hexdigest

# Generate file digest
Digest::CRC32.file('filename.txt').hexdigest
```

## Performance

Let's compare this gem with few others:
* [crc32](https://github.com/tdobrovolskij/crc32) which provides C extension with
the same algorithm but without all that fancy Digest module staff. It has only one method
`calculate`. So you should care about previous crc32 digests and data length by yourself
* Standard zlib ruby implementation
* [digest-crc](https://github.com/postmodern/digest-crc) which is pure Ruby
implementation of few CRC-algorithms

### Benchmarking method

First of all we will create a string with random data provided by `SecureRandom.random_bytes`.
I choosed variable with 5 megabytes of random bytes
Next let's create digest for that string 1000 times by each of gems.

*All benchmarks performed on MacBook Pro 15 mid 2015 with 2,2 GHz Intel Core i7*

### Results

```
                           user      system     total       real
crcs                    12.660000   0.030000  12.690000 ( 12.709954)
tdobrovolskij/crc32      3.550000   0.010000   3.560000 (  3.574127)
zlib                     0.470000   0.000000   0.470000 (  0.471863)
postmodern/digest-crc  947.670000   1.330000 949.000000 (950.414528)
```
For some reasons my gem is terribly slower than crc32 and zlib libraries. I think
it's caused by overhead of creating digest objects and other things that happening inside
of that module. Maybe I should extract my code to separate class and try again?
Fortunately, as you can see, my gem isn't so bad comparing with pure ruby implementation.

