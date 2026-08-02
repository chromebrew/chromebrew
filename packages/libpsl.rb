require 'buildsystems/meson'

class Libpsl < Meson
  description 'C library for the Public Suffix List'
  homepage 'https://github.com/rockdaboot/libpsl'
  version '0.23.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rockdaboot/libpsl.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2c403cf7137dba0eee692bd01058483e6e461d9ff11f12de3fb8c98b7d3d6bde',
     armv7l: '2c403cf7137dba0eee692bd01058483e6e461d9ff11f12de3fb8c98b7d3d6bde',
       i686: 'eadc5b22ef51320156d54c656603f511e6bfb8d02b2379ff9914b7ad882360df',
     x86_64: '98e8f1018ef02973e17398a8d1c2fb7cdda755192076b338ed21d38e5fbc4e46'
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
