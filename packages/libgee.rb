require 'package'

class Libgee < Package
  description 'Libgee is an utility library providing GObject-based interfaces and classes for commonly used data structures.'
  homepage 'https://wiki.gnome.org/Projects/Libgee'
  version '0.20.3'
  source_url 'https://download.gnome.org/sources/libgee/0.20/libgee-0.20.3.tar.xz'
  source_sha256 'd0b5edefc88cbca5f1709d19fa62aef490922c6577a14ac4e7b085507911a5de'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgee-0.20.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgee-0.20.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgee-0.20.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgee-0.20.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5b56ee3c98f061b93b725b1b9ca2d1e5ce8b5e1bf17c30c361a20de0874079fd',
     armv7l: '5b56ee3c98f061b93b725b1b9ca2d1e5ce8b5e1bf17c30c361a20de0874079fd',
       i686: '6987e6ff636e7d964a2427ea298597985c0f5c0ec218615559560e5c0954d452',
     x86_64: '227764127203eff1a10ec93f248a047c13744f51a41b4cce2aea71da274e8266',
  })

  def self.build
    ENV['TMPDIR'] = "#{CREW_PREFIX}/tmp"
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
