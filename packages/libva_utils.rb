require 'package'

class Libva_utils < Package
  description 'Libva-utils is a collection of tests for VA-API (VIdeo Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  @_ver = '2.10.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/intel/libva-utils/archive/#{@_ver}.tar.gz"
  source_sha256 'cbb7f9f6eae21d772e31b67bc8c311be6e35fe9c65e63acc57f9b16d72bf8dc0'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libva_utils-2.10.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libva_utils-2.10.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libva_utils-2.10.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libva_utils-2.10.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '18034e1875d75a811424decae53f36bf84ac1c089cabd9287dc6dce20633b81c',
     armv7l: '18034e1875d75a811424decae53f36bf84ac1c089cabd9287dc6dce20633b81c',
       i686: '3d66fe13689f3e46404d87847fc83e216f8f48e1c3c677c2b50ab534324c3472',
     x86_64: '3a5bec9cc90d365adffa786a0f35d1e211fcec071244046719246d5c7be74084'
  })

  depends_on 'libva'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
