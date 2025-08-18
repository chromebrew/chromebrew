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
    aarch64: 'd27d65847af22a3a9f4776bb005baee84c850d7c41fbc7331aac96eaad5e7801',
     armv7l: 'd27d65847af22a3a9f4776bb005baee84c850d7c41fbc7331aac96eaad5e7801',
     x86_64: 'c5f806dd18fe1485a1255cc9ce19749f08397b8b61bb5a3192008e4f33591e05'
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
