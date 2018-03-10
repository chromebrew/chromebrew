require 'package'

class Libwayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version '1.14.91'
  source_url 'https://wayland.freedesktop.org/releases/wayland-1.14.91.tar.xz'
  source_sha256 '25b9d3dd8a69b1b3533cf1b98e5a48f6b1466799171d429778b69c41bc477ef8'

  binary_url ({

  })
  binary_sha256 ({

  })

  depends_on 'libffi'
  depends_on 'expat'
  depends_on 'libxml2'
  depends_on 'libxslt'  

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --disable-documentation"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
