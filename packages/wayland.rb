require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version '1.16.0'
  source_url 'https://wayland.freedesktop.org/releases/wayland-1.16.0.tar.xz'
  source_sha256 '4e72c2b56109ccfb6610d776e465f4ca0af2280c9c2f7d5cc23f0ed2548752f5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.16.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.16.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.16.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.16.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f1377f242b5971d95f79351bd46a7fe938c28292d0c1b270445b978fe828bb4e',
     armv7l: 'f1377f242b5971d95f79351bd46a7fe938c28292d0c1b270445b978fe828bb4e',
       i686: '7a601e7b17493ad3f72f7248ba031fda587e9223398205701be82e74be8c95a8',
     x86_64: '6f4ac29bcad6eb9160b1da611e189b744a5ba5945b20318d72639962a9f2a917',
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
