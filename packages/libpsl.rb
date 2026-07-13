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
    aarch64: '224316f5e0b67623173199d98c2e97b8289a12979335a0f6fe3956ba1b338203',
     armv7l: '224316f5e0b67623173199d98c2e97b8289a12979335a0f6fe3956ba1b338203',
       i686: '6922e7d8e80b108bc9f2d3827d4573401280b1b021089f983405743aa2586660',
     x86_64: '38a4a1e7218aec934834109909d1c16e492ceef7d740cb1413254d68ceead2bb'
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
