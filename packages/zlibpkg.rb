require 'package'

class Zlibpkg < Package
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'http://www.zlib.net/'
  version '1.2.11-3'
  compatibility 'all'
  source_url 'http://www.zlib.net/zlib-1.2.11.tar.gz'
  source_sha256 'c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zlibpkg-1.2.11-3-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zlibpkg-1.2.11-3-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/zlibpkg-1.2.11-3-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zlibpkg-1.2.11-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '32adce95047eab53e31ee93794255159cc839ef5cdac1da46ed0ff5a15812df4',
      armv7l: '32adce95047eab53e31ee93794255159cc839ef5cdac1da46ed0ff5a15812df4',
        i686: 'd74959077aadf86030e2acd969923d23fa042d67bf5f1fe1cc91af09816f70e6',
      x86_64: '8fab32aaf18449efe4140af1cd2af1abaf7543314524508b888d7ef4019d581f',
  })


  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.check
    system 'make check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
