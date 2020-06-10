require 'package'

class Zlibpkg < Package
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'http://www.zlib.net/'
  version '1.2.11-2'
  compatibility 'all'
  source_url 'http://www.zlib.net/zlib-1.2.11.tar.gz'
  source_sha256 'c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1'

  binary_url ({	
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zlibpkg-1.2.11-2-chromeos-armv7l.tar.xz',	
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zlibpkg-1.2.11-2-chromeos-armv7l.tar.xz',	
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/zlibpkg-1.2.11-2-chromeos-i686.tar.xz',	
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zlibpkg-1.2.11-2-chromeos-x86_64.tar.xz',	
  })	
  binary_sha256 ({	
    aarch64: '05c91e73a746eb34abebaf8ca8d22732d67465299aa5c3127fb74916e15d6323',	
     armv7l: '05c91e73a746eb34abebaf8ca8d22732d67465299aa5c3127fb74916e15d6323',	
       i686: '0302d82be0083ab3034909c0111ccddf8d94e83bf0a6218523d49d502876796b',	
     x86_64: '79e08846bb5d73f07cfe0a515cf46a060c2f96ad95651e7d2e5bced93f52ade4',	
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

    # remove static library since there is no configuration option to not create it.
    FilUtils.rm "#{CREW_DEST_LIB_PREFIX}/libz.a"
  end
end
