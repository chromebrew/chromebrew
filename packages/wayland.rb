require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version '1.18.0'
  compatibility 'all'
  source_url 'https://wayland.freedesktop.org/releases/wayland-1.18.0.tar.xz'
  source_sha256 '4675a79f091020817a98fd0484e7208c8762242266967f55a67776936c2e294d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.18.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.18.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.18.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland-1.18.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0df3da39ddbfc87a0d4986c3dce8bf94ffc44d8333b3a9f9eae9c8b92f276e69',
     armv7l: '0df3da39ddbfc87a0d4986c3dce8bf94ffc44d8333b3a9f9eae9c8b92f276e69',
       i686: '22cbbe4b83eb9a6fc5e5cbac4946c72d7d6cd9bd8f3db3f208c049d406374d5a',
     x86_64: 'bf28cacca6c316fba02ddb76bcd029034bedfd0ca3537231efce89b1ab81aa09',
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
