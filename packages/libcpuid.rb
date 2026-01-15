require 'buildsystems/cmake'

class Libcpuid < CMake
  description 'libcpuid is a small C library for x86 CPU detection and feature extraction.'
  homepage 'https://libcpuid.sourceforge.net/'
  version '0.8.1-1'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/anrieff/libcpuid.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'affcac85b0eb6f7c415a34ed86f94f948eda4464ce96d79c17848918453c5cd5',
     armv7l: 'affcac85b0eb6f7c415a34ed86f94f948eda4464ce96d79c17848918453c5cd5',
       i686: '5f0dd8ef434531969d086e4c101ef3c9a3e11bb756bd167cf951d984b7456e62',
     x86_64: '061e50e4102230acbe8cbeeeb2376ab2f290e811ee94922d56642f383e1a6bf3'
  })

  depends_on 'glibc' # R

  run_tests

  def self.patch
    patches = [
      # Fix libdir
      ['https://github.com/anrieff/libcpuid/pull/221.diff',
       '2a8cdd016bf9f5996e544c5e58b364f59d5fcfb426568bd6e1369a7c428c83a6']
    ]
    ConvenienceFunctions.patch(patches)
  end
end
