require 'buildsystems/meson'

class Libpsl < Meson
  description 'C library for the Public Suffix List'
  homepage 'https://github.com/rockdaboot/libpsl'
  version '0.21.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rockdaboot/libpsl.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33bd40a1ed45022c73edba450ea4c6880852a191a2efa14d94956cbb8b84dc92',
     armv7l: '33bd40a1ed45022c73edba450ea4c6880852a191a2efa14d94956cbb8b84dc92',
       i686: '2a9b55b193a0525fd07f1a5c5a67cfa1f913a4731e05a500a78112e2459d425a',
     x86_64: 'efdc1d563225e066bb9ec3415715d721fcff2caf24d7304670bea57999c1f649'
  })

  depends_on 'glibc' # R
  depends_on 'libidn2' # R
  depends_on 'libunistring' # R
  depends_on 'python3' => :build

  # https://github.com/rockdaboot/libpsl/issues/218
  # run_tests
end
