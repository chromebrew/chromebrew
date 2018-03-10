require 'package'

class Wayland_protocols < Package
  description 'Wayland is a protocol for a compositor to talk to its clients'
  homepage 'https://wayland.freedesktop.org'
  version '1.13'
  source_url 'https://wayland.freedesktop.org/releases/wayland-protocols-1.13.tar.xz'
  source_sha256 '0758bc8008d5332f431b2a84fea7de64d971ce270ed208206a098ff2ebc68f38'

  binary_url ({

  })
  binary_sha256 ({

  })

  depends_on 'libwayland'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
