require 'package'

class Wayland_protocols < Package
  description 'Wayland is a protocol for a compositor to talk to its clients'
  homepage 'https://wayland.freedesktop.org'
  version '1.13'
  source_url 'https://wayland.freedesktop.org/releases/wayland-protocols-1.13.tar.xz'
  source_sha256 '0758bc8008d5332f431b2a84fea7de64d971ce270ed208206a098ff2ebc68f38'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.13-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: 'bd0eb42679be30bddbbe20bb254508be16d8a4f5566c246885fb20a94a2fc3d7',
     armv7l: 'bd0eb42679be30bddbbe20bb254508be16d8a4f5566c246885fb20a94a2fc3d7',
       i686: 'ef466cc4ddca3c0d6069c3cdb110d5024b533d78be6512dff377751affe76f94',
     x86_64: '3d3471f15e2f7e80cef25f272d1f0e29cb0e323e78beaa479df8d319f3b3d477',

  })

  depends_on 'libwayland'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
