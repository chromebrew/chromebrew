require 'package'

class Libva_utils < Package
  description 'Libva-utils is a collection of tests for VA-API (VIdeo Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  version '2.11.1'
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/intel/libva-utils/archive/refs/tags/#{version}.tar.gz"
  source_sha256 '0c1eb7f717e391d00da74c53a9fe5caf3d6c510dcd35bac7f71a0e59ad1b8d26'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '96b6472a638dc5b6269460b49ff4dab1063b7a9227a07cef8aa2aea5bb7d14f1',
     armv7l: '96b6472a638dc5b6269460b49ff4dab1063b7a9227a07cef8aa2aea5bb7d14f1',
       i686: '4e89b693c082deaab2c675597818eafbcec899d2dcaf59d4bf9a8b947c71d9ff',
     x86_64: '2a2f1a713b00c8a14aeacb73f2cfb599f54cd147d02a001eb99f456fd859e17c'
  })

  depends_on 'libva'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
