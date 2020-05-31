require 'package'

class Libvdpau < Package
  description 'VDPAU is the Video Decode and Presentation API for UNIX. It provides an interface to video decode acceleration and presentation hardware present in modern GPUs.'
  homepage 'https://www.freedesktop.org/wiki/Software/VDPAU/'
  version '1.3'
  source_url 'https://gitlab.freedesktop.org/vdpau/libvdpau/-/archive/1.3/libvdpau-1.3.tar.bz2'
  source_sha256 'b5a52eeac9417edbc396f26c40591ba5df0cd18285f68d84614ef8f06196e50e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libvdpau-1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libvdpau-1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libvdpau-1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libvdpau-1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b3b560d72b7877db7cad6f15d79c35ae118fc8804c64be8192b7f4a1930b138c',
     armv7l: 'b3b560d72b7877db7cad6f15d79c35ae118fc8804c64be8192b7f4a1930b138c',
       i686: '6f703f96ce0e186605c64550ae9ad0b43e0f3a55b3e26dbbb8074af1bb0623ba',
     x86_64: 'd1f759f51a5888850e54415ca03983e01e960941d3859e88c8b1891fdee1afb1',
  })

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
