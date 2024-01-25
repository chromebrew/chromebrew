require 'package'

class Libwpe < Package
  description 'General-purpose library for WPE WebKit'
  homepage 'https://wpewebkit.org'
  version '1.14.0'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://github.com/WebPlatformForEmbedded/libwpe/releases/download/#{version}/libwpe-#{version}.tar.xz"
  source_sha256 'c073305bbac5f4402cc1c8a4753bfa3d63a408901f86182051eaa5a75dd89c00'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd56fb79ad0b2dbd584cb8d1e0fc14adafcde48059a61a5b6f274d748b2fcd151',
     armv7l: 'd56fb79ad0b2dbd584cb8d1e0fc14adafcde48059a61a5b6f274d748b2fcd151',
       i686: 'b1c5159036dbaed97bc7e239431fc22efa8465db35277326e057f80041edb85f',
     x86_64: '910bf8a7b96f7d9f9d4990cc1ba4b20849785444f00537ae97b92ffc85d11563'
  })

  depends_on 'libxkbcommon'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
