require 'package'

class Zlibpkg < Package
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'http://www.zlib.net/'
  @_ver = '1.2.11'
  version "#{@_ver}-4"
  compatibility 'all'
  source_url "http://www.zlib.net/zlib-#{@_ver}.tar.gz"
  source_sha256 'c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zlibpkg-1.2.11-4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zlibpkg-1.2.11-4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/zlibpkg-1.2.11-4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zlibpkg-1.2.11-4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4b9c8b7ae88784f0c2744f268cc31afa1bb467f2ea964a7cb601509f12fceee7',
     armv7l: '4b9c8b7ae88784f0c2744f268cc31afa1bb467f2ea964a7cb601509f12fceee7',
       i686: 'fdd119fa2214635decf1a926a762cffc6e76a9ee4986d3a601c2afee05b150b8',
     x86_64: '16c5a9c26c5ba526ae48dfaf277bb31c471bde9982747035f3e7594f4da710e8'
  })

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.check
    system 'make check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
