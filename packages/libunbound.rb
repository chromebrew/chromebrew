require 'package'

class Libunbound < Package
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  @_ver = '1.13.0'
  version @_ver
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{@_ver}.tar.gz"
  source_sha256 'a954043a95b0326ca4037e50dace1f3a207a0a19e9a4a22f4c6718fc623db2a1'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.13.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.13.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.13.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.13.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '6a233948f7d41046dc23d1cc500cf87b604b6d99861d0806b12393e090bd034a',
      armv7l: '6a233948f7d41046dc23d1cc500cf87b604b6d99861d0806b12393e090bd034a',
        i686: '93afb3cb2cbdd9e3fa293b6f04475a7f5cf4e0f713d7eba3538f2547c4547d1a',
      x86_64: 'b270594cf7ac23a675280e20807730ae437f155a41c4f015b17db51c4bb360de',
  })

  def self.build
  system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
    ./configure \
    #{CREW_OPTIONS} \
    --enable-shared \
    --with-pic"
    system "make"
  end
  
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
  
  def self.check
    system 'make', 'test'
  end
end
