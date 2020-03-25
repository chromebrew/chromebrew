require 'package'

class Libvdpau < Package
  description 'VDPAU is the Video Decode and Presentation API for UNIX. It provides an interface to video decode acceleration and presentation hardware present in modern GPUs.'
  homepage 'https://www.freedesktop.org/wiki/Software/VDPAU/'
  version '1.3-1'
  source_url 'https://gitlab.freedesktop.org/vdpau/libvdpau/-/archive/1.3/libvdpau-1.3.tar.bz2'
  source_sha256 'b5a52eeac9417edbc396f26c40591ba5df0cd18285f68d84614ef8f06196e50e'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
