require 'package'

class Windowswmproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.0.4'
  source_url 'https://www.x.org/archive/individual/proto/windowswmproto-1.0.4.tar.gz'
  source_sha256 '2dccf510cf18a1b5cfd3a277c678d88303efc85478b479fec46228a861956eb7'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/windowswmproto-1.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/windowswmproto-1.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/windowswmproto-1.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/windowswmproto-1.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e23df6804b629c8f4d87af8969eb36936314c03142538fb79eb79e042e42741c',
     armv7l: 'e23df6804b629c8f4d87af8969eb36936314c03142538fb79eb79e042e42741c',
       i686: '6ae081cd1407a5b600f60ce095d885f22204d72478d2d7e3028dac2e01c04242',
     x86_64: 'fbff6ae450b797515fa295020f6326faad158eeb81a5f1f9fbf5dd8e335fa8a1',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
