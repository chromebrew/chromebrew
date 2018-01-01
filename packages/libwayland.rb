require 'package'

class Libwayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version '1.14.0'
  source_url 'https://wayland.freedesktop.org/releases/wayland-1.14.0.tar.xz'
  source_sha256 'ed80cabc0961a759a42092e2c39aabfc1ec9a13c86c98bbe2b812f008da27ab8'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libffi'
  depends_on 'expat'
  depends_on 'libxml2'

  def self.build
    system "./configure --disable-documentation"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
