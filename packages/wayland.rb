require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version '1.18.0'
  source_url 'https://wayland.freedesktop.org/releases/wayland-1.18.0.tar.xz'
  source_sha256 '4675a79f091020817a98fd0484e7208c8762242266967f55a67776936c2e294d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libpng'
  depends_on 'libxslt'
  # depends_on 'graphviz' => :build # GraphViz doesn't have PNG support enabled

  def self.build
    system './configure',
           '--disable-documentation', # See above comment
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
