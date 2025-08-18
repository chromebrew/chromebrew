require 'package'

class Libva_utils < Package
  description 'Libva-utils is a collection of tests for VA-API (VIdeo Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  version '2.22.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/intel/libva-utils/archive/refs/tags/#{version}.tar.gz"
  source_sha256 '7b57615c130427ec134bb5d2b80af516ce5bb19a40e89b1dab46a0d59760d96c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '96b6472a638dc5b6269460b49ff4dab1063b7a9227a07cef8aa2aea5bb7d14f1',
     armv7l: '96b6472a638dc5b6269460b49ff4dab1063b7a9227a07cef8aa2aea5bb7d14f1',
     x86_64: '2a2f1a713b00c8a14aeacb73f2cfb599f54cd147d02a001eb99f456fd859e17c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'libx11' # R
  depends_on 'wayland' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
