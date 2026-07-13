require 'buildsystems/meson'

class Libpsl < Meson
  description 'C library for the Public Suffix List'
  homepage 'https://github.com/rockdaboot/libpsl'
  version '0.23.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rockdaboot/libpsl.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7ed90011190545848f68d4cfcef52dbe26d17feacd1c47931ed17d0da3a6cf6d',
     armv7l: '7ed90011190545848f68d4cfcef52dbe26d17feacd1c47931ed17d0da3a6cf6d',
       i686: 'a96e5776b74d7b2a3b826efcc3ce0f2c567f43a633642f43a541adf495bb388e',
     x86_64: '8a4c01a650aa69aead1c58bca4c78ed55364347fa91c400ab68fb3c00831e642'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libidn2' => :library
  depends_on 'libunistring' => :library

  def self.patch
    # Update the PSL during build.
    downloader 'https://github.com/publicsuffix/list/raw/refs/heads/main/public_suffix_list.dat', 'SKIP', 'list/public_suffix_list.dat'
  end
end
