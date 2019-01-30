require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version '1.16.0'
  source_url 'https://wayland.freedesktop.org/releases/wayland-1.16.0.tar.xz'
  source_sha256 '4e72c2b56109ccfb6610d776e465f4ca0af2280c9c2f7d5cc23f0ed2548752f5'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'expat'
  depends_on 'libpng'
  depends_on 'libffi'
  depends_on 'libxml2'
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
